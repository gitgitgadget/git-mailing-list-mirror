From: Neal Kreitzinger <neal@rsss.com>
Subject: RE: Tonight's pushout
Date: Fri, 10 Dec 2010 01:25:16 +0000
Message-ID: <E54235A96EB484418EBD9509F37176D210049AEE@htmail10.hightouchinc.com>
References: <7v8w01m27t.fsf@alter.siamese.dyndns.org>
 <idotn7$9o7$1@dough.gmane.org> <20101209200143.GC6884@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 02:47:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQs58-0007Ma-9L
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 02:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757721Ab0LJBqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 20:46:31 -0500
Received: from mail.hightouchinc.com ([64.66.99.145]:27753 "EHLO
	htnospam.hightouchinc.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757433Ab0LJBqa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Dec 2010 20:46:30 -0500
X-Greylist: delayed 1263 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Dec 2010 20:46:30 EST
Received: from htnospam.hightouchinc.com (127.0.0.1) by htnospam.hightouchinc.com (MlfMTA v3.2r9) id h0637c0171s4 for <git@vger.kernel.org>; Thu, 9 Dec 2010 19:25:19 -0600 (envelope-from <neal@rsss.com>)
Received: from htmail10.hightouchinc.com ([172.19.10.53])
	by htnospam.hightouchinc.com (SonicWALL 7.2.4.3925)
	with ESMTP; Thu, 09 Dec 2010 19:25:19 -0600
Received: from htmail10.hightouchinc.com ([fe80::cdfc:24b4:b881:8bf1]) by
 htmail10.hightouchinc.com ([::1]) with mapi id 14.01.0180.002; Thu, 9 Dec
 2010 19:25:18 -0600
Thread-Topic: Tonight's pushout
Thread-Index: AQHLl9vygcsnZdbOkUq8boopHnixdpOY2zeQ
In-Reply-To: <20101209200143.GC6884@burratino>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.2.210]
X-Mlf-Version: 7.2.4.3925
X-Mlf-UniqueId: o201012100125190053071
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163378>

Jonathan,

Thanks for pointing that out.  I tried to preserve the cclist per your observation.  My newsreader is outlook express and my mail client is outlook.  As a result, I can only preserve the entire cc list on actual emails in my inbox.  So in this case Junio was preserved in the cclist because I was able to reply-to-all in outlook (not outlook express).  (But I took him out manually because I don't want to annoy him.)  If I reply to a message on the newsgroup that was not explicitly emailed to me, then only the newsgroup is cc'd and any extra-newsgroup cc list is lost.  I can see the sender's original cc list in outlook express in a header box at the top of the message preview pane, but I can't copy it (not even with hilite-copy).  So in those cases I can only reply to the sender and the newsg
 roup, not to the extra-newsgroup cc list.  Outlook only allows:

"reply to newsgroup and not anyone else, not even the sender" (aka Reply-Group), 
"reply only to the sender" (aka Reply),
"reply to the sender and cc the newsgroup only" (aka Reply-All)

There is no option to "reply to sender and preserve the sender's entire original cc list".

Maybe I need a better newsreader.  I like how outlook express keeps the threads grouped together by the parent thread so I can expand the thread or collapse it.  I don't like that can't preserve the extra-newgroup cclist.  I appreciate your help as this is my first newsgroup I've ever posted to, and I apologize for any bad-newsgroup-etiquette due to my ignorance.

v/r,
Neal

-----Original Message-----
From: Jonathan Nieder [mailto:jrnieder@gmail.com] 
Sent: Thursday, December 09, 2010 2:02 PM
To: Neal Kreitzinger
Cc: git@vger.kernel.org; Junio C Hamano
Subject: Re: Tonight's pushout

Neal Kreitzinger wrote:

> "prerelease freeze" is not in the git-workflows manpage.  I'm interested in 
> how you-all do this because I use the git-workflows mangpage to help me 
> figure out my workflows.  Can someone explain?

See http://en.wikipedia.org/wiki/Freeze_(software_engineering)

In git's incarnation of it, presumably the idea is that new features
do not get merged to 'master' (while they still would be merged to
'pu' and perhaps 'next').

See also <http://sites.google.com/site/maintnotes/> for some direct
discussion of the branches used by git.git.

Hope that helps,
Jonathan [1]

[1] Unrelated note: please try to preserve the cc list in replies
(i.e., "reply-to-all-by-mail" rather than "followup").

"This message may contain confidential and/or privileged 
information. If you are not the addressee or authorized to 
receive this for the addressee, you must not use, copy, 
disclose, or take any action based on this message or any 
information herein. If you have received this message in error, 
please advise the sender immediately by reply e-mail and delete 
this message. Thank you for your cooperation."
