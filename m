From: Brett Schwarz <brett_schwarz@yahoo.com>
Subject: Re: [PATCH] user-manual: mention git gui citool (commit, amend)
Date: Sun, 5 Aug 2007 20:33:29 -0700 (PDT)
Message-ID: <608102.66070.qm@web38905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 05:33:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHtLa-0006rW-Cl
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 05:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757832AbXHFDdb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 23:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755858AbXHFDdb
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 23:33:31 -0400
Received: from web38905.mail.mud.yahoo.com ([209.191.125.111]:27086 "HELO
	web38905.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755310AbXHFDda convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 23:33:30 -0400
Received: (qmail 66075 invoked by uid 60001); 6 Aug 2007 03:33:29 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=WK1wZ9tvzBhoo7frMc2pFBs4EDdeKAujw9BD6SbORkRm2tdLASd/4Dr4yncUlZBrfsIzUXZnQCtGDvts64DF3TQqg9XD4nbtLt3eHTtmSQEHBs7CGCvRXfaBhlnG2lcEV1ygVaYmx1ftKkyBEpaw6C6Sg4cgYGiaTd0no0W27UM=;
X-YMail-OSG: dMwwCk8VM1m0k4sKmhr4GlEo_aFRNMZ7jkdwjfrH0y7J2PJVhNgZj3gT4rwvTx_kpP7JF215UVJnhEcwvhbkpKvPtWvqUEhtTNSo1T7cRAM.IkLS1.Fiki_HlA--
Received: from [24.16.125.24] by web38905.mail.mud.yahoo.com via HTTP; Sun, 05 Aug 2007 20:33:29 PDT
X-Mailer: YahooMailRC/651.41 YahooMailWebService/0.7.119
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55103>

> 
> ----- Original Message ----
> From: Shawn O. Pearce <spearce@spearce.org>
> To: J. Bruce Fields <bfields@fieldses.org>
> Cc: Steffen Prohaska <prohaska@zib.de>; git@vger.kernel.org
> Sent: Friday, August 3, 2007 11:20:10 PM
> Subject: Re: [PATCH] user-manual: mention git gui citool (commit, amend)
> 
> "J. Bruce Fields" <bfields@fieldses.org> wrote:
> > On Thu, Aug 02, 2007 at 11:04:59PM -0400, Shawn O. Pearce wrote:
> > > Online help?  In git-gui?  :-)
> > >
> > > We don't have an online help system yet.
> >
> > Fair enough.
> >
> > Though I'd like to keep the main body of the manual focused on the major
> > command line tools, I'd have no objection to a separate chapter (or
> > appendix?) devoted to git-gui; then you could point directly at that.
> > Would that make sense?
> 
> Yea, that makes a lot of sense.  git-gui isn't a full replacement
> for the command line anyway, so I would never suggest a wholesale
> rewrite of the user manual to slant the entire thing towards git-gui.
> Doing so would only point out the many shortcomings in git-gui.  :)
> 
> I haven't explored any in-Tk rendering options yet, been too busy
> with other projects.  Ideally I'd like to just render the asciidoc
> markup directly, but I don't think anyone has done an asciidoc
> viewer for Tk.  I can't imagine it would be that difficult to get
> some sort of parser working though...
> 
> 

So, I took a stab at this earlier today, and it is fairly straight forward. I have 
something that is semi working (I haven't tested all the scenarios yet), but 
the rest is just really filling in the blanks.

Question though: I was going to have a index tree on a side panel...but do
 you want this thing to only bring up the git-gui.txt file, and show the table 
of contents, or do you want all *.txt files in the index? Or .... ?

Thanks,
    --brett





       
____________________________________________________________________________________
Be a better Globetrotter. Get better travel answers from someone who knows. Yahoo! Answers - Check it out.
http://answers.yahoo.com/dir/?link=list&sid=396545469
