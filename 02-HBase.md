# HBase

Apache HBase is made for big jobs, like a nail gun. You would never use HBase to catalog your corporate sales list or build a to-do list app for fun, just like you’d never use a nail gun to build a doll house. If the size of your dataset isn’t many, many gigabytes at the very least then you should probably use a less heavy-duty tool.

At first glance, HBase looks a lot like a relational database, so much so that if you didn’t know any better, you might think that it is one. In fact, the most challenging part of learning HBase isn’t the technology; it’s that many of the words used in HBase are deceptively familiar. For example, HBase stores data in buckets it calls tables, which contain cells that appear at the intersection of rows and columns. Sounds like a relational database, right?

Wrong! In HBase, tables don’t behave like relations, rows don’t act like records, and columns are completely variable and not enforced by any predefined schema. Schema design is still important, of course, because it informs the performance characteristics of the system, but it won’t keep your house in order—that task falls to you and how your applications use HBase. In general, trying to shoehorn HBase into an RDBMS-style system is fraught with nothing but peril and a certain path to frustration and failure. HBase is the evil twin, the bizarro doppelgänger, if you will, of RDBMS.

