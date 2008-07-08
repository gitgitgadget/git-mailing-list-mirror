From: Jakub Narebski <jnareb@gmail.com>
Subject: [GSoC] What is status of Git's Google Summer of Code 2008 projects?
Date: Tue, 8 Jul 2008 02:27:41 +0200
Message-ID: <200807080227.43515.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam@vilain.net>, Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 02:28:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG14f-0003rK-4T
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 02:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792AbYGHA1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 20:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754759AbYGHA1z
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 20:27:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:32625 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721AbYGHA1y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 20:27:54 -0400
Received: by nf-out-0910.google.com with SMTP id d3so711711nfc.21
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 17:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        bh=omznbV8j9k4tXuP2cansZGkIsopvH7yArMP8qJJBLfY=;
        b=x2zWcAcOcfm+OesULjQ4zX624+xMhhG8dfbR/c1JXZOBqpfDkLZay+/8JRdENoYZZN
         k/li/+d6meJAbrO03hak1z8D5Iy4PfG6EWZs3AOiay1MZcDge883F0v824gkdhQV6vBu
         NyqwMzBvOOlarEPlKJxBwQYOU5EsTcH6WDyCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-disposition
         :content-type:content-transfer-encoding:message-id;
        b=ao/NEzIqLLeNF1HZ2U4Gf/p6svhdq7JhXLAuRhFiaFBZE1NjCfYVckwMnerR9rGita
         JzomRByeJALmXqCfPMKTwTeZwnlpMPHThaRNtSh2L/jaXSRdxsyh2mf2Jrjb3watxXD0
         1w8H/HdKpEA2qj+T4EwLWL+ZLzA9FLFoaHY/U=
Received: by 10.210.28.6 with SMTP id b6mr3561214ebb.121.1215476872190;
        Mon, 07 Jul 2008 17:27:52 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.206.62])
        by mx.google.com with ESMTPS id b36sm7525377ika.5.2008.07.07.17.27.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jul 2008 17:27:49 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87670>

I'd very much like to have (or perhaps to wrote) some sort of interim 
progress report for Google Summer of Code 2008 projects on 
http://git.or.cz/gitwiki/SoC2008Projects.  Therefore I'd like you to 
expand and/or correct those mini-summaries below.

(It would be, I guess, good preparation for GSoC 2008 mid-term 
evaluations, which according to GSoC 2008 timeline
  http://code.google.com/opensource/gsoc/2008/faqs.html#0.1_timeline
are to take place July 7 -- July 14.)


1. GitTorrent (???)

Student: Joshua Roys
Mentor: Sam Vilain

There was short thread of me asking about project
  http://thread.gmane.org/gmane.comp.version-control.git/83611
where I got gittorrent mailing list (no activity at least according to 
list archive http://lists.utsl.gen.nz/pipermail/gittorrent/) and URL 
for project repo / gitweb... which is currently down, so I cannot check 
if there is anything here.

What is the status of this project, please?

http://www.codinghorror.com/blog/archives/001134.html ("Don't Got Dark")


2. git-statistics (?)

Student: Sverre Rabbelier
Mentor: David Symonds

There were some posts about how git-statistics can be used:
  http://thread.gmane.org/gmane.comp.version-control.git/81534
  http://thread.gmane.org/gmane.comp.version-control.git/82027
but it was mainly theoretical thread

The git-stats repository at http://repo.or.cz/w/git-stats.git (gitweb) 
has some commits, but I don't remember any of them on git mailing list.
Not ready?


3. Gitweb caching

Student: Lea Wiemann
Mentor: John 'warthog' Hawley

Lea has chosen caching data and memcached as primary caching engine,
and is working on object layer on top of Git.pm, namely Git::Repo and 
friends, which will be used by gitweb.  If I understand correctly 
caching is to be done, or at least helped by this layer.

There were added tests for Git.pm (now in git.git I think) and Mechanize 
test for gitweb (which detected a few errors).

Is it correct?


4. Eclipse plugin push support (!)

Student: Marek Zawirski
Mentor: Shawn O. Pearce

I am not following egit/jgit development close enough, but if I remember 
correctly there is some code which provides very rudimentary support 
for native generation of simplified packs, and IIRC also for push over 
some protocols.

And there is push support over SFTP and (encrypted) Amazon S3...


5. git-merge builtin (!!!)

Student: Miklos Vajna
Mentor: Johannes Schindelin

Builtin merge, together with preparation patches, is now at n-th 
iteration, as shown in the "Build in merge" thread:
  http://thread.gmane.org/gmane.comp.version-control.git/86584

In "What's cooking in git.git (topics)" Junio C Hamano wrote:

  It already is beginning to become clear what 1.6.0 will look like.
  [...]
  * git-merge will be rewritten in C.


6. git-sequencer (!)

Student: Stephan Beyer
Mentor: Christian Couder, Daniel Barkalow

It started with discussion over TODO file format:
  http://thread.gmane.org/gmane.comp.version-control.git/84230

Now there is prototype shell script implementation (which has some 
limitations because it is prototype) in "git sequencer prototype"
  http://thread.gmane.org/gmane.comp.version-control.git/86985

Stephan Beyer wrote:
  I'm using sequencer-based git-am and git-rebase-i and also 
  git-sequencer itself for around 2-3 weeks now. So, for me, it is
  reality-proven [...]

-- 
Jakub Narebski
Poland
