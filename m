From: Jakub Narebski <jnareb@gmail.com>
Subject: [GSoC] Git projects for Google Summer of Code 2008 final evaluation
Date: Thu, 4 Sep 2008 23:15:56 +0200
Message-ID: <200809042315.58898.jnareb@gmail.com>
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
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 23:17:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbMCX-00030H-Uw
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 23:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbYIDVQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 17:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753801AbYIDVQG
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 17:16:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:65193 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041AbYIDVQD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 17:16:03 -0400
Received: by fg-out-1718.google.com with SMTP id 19so539477fgg.17
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 14:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=13jTSvnFe98pZibsMaJnPUpwlV+nKc7qma0prW4EZBA=;
        b=GXxROINqwf9bGzq0bXKcR+5ay4VdHf+XAPrbxLgR9zKCCwXwZwpfNWc4C7J/jAkHKf
         pbBXytTLBdDwvCwrKStOlFU560KwdZNBh59a7/i59Ni5TSPTMDYKTd0P03J7uU5Krhu7
         PMHlrxAHNdGQrwmDv6nrxehLgyVJXQ69V3KY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=lUOCp8qt8SQtBthjLiwgm+RBm/OQK2YLS/SkjZH0xvQgD9IyZ/vleR58nVkeIN0MOn
         P5t9ibr6B1m2LKWMmIZ+lBbQAkVBpR5J3kRtJ9GRq6bJ9LURycbd9Dj+L/fb5MS1ftCQ
         ivMgt5JLoRW/mSpvYUegKFemOH7m78BvxG5/4=
Received: by 10.86.80.17 with SMTP id d17mr8106350fgb.41.1220562960448;
        Thu, 04 Sep 2008 14:16:00 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.201.254])
        by mx.google.com with ESMTPS id 4sm105389fge.8.2008.09.04.14.15.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Sep 2008 14:15:59 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94959>

We are now according to Google Summer of Code 2008 timeline
  http://code.google.com/opensource/gsoc/2008/faqs.html#0.1_timeline
after final evaluation deadline (September 2: 12:00 PDT / 19:00 UTC).

Therefore I and perhaps other on git mailing list would like to know 
what is the status of all git GSoC 2008 projects. We could then write
summary about each project at http://git.or.cz/gitwiki/SoC2008Projects
page.

So students and mentors, please write what do you think current status 
of project is: is it done, is it ready, is it perhaps already merged 
in, or can be merged in at any time.  Please write also what wasn't 
done, or what should be done different way (hindsight and all that).

Students, could you please tell us if you plan to work on git further, 
and in what range (how much time can you get to work on git). What do 
you think about git development community? What have you learned from 
participating in GSoC?

Mentors, could you tell us your side about how it was working as a 
mentor for Google Summer of Code? Perhaps some tricks of trade?
Have you herd perhaps about non-Git projects involving Git, like
Git# project(s) from Mono, DVCS support for KDevelop from KDE,
Git plugin for Anjuta IDE from GNOME; how did they fare?

Thank you all very much for your work on Git projects on this Google 
Summer of Code.


Below there is list of various Git's Google Summer of Code 2008 
projects, in the sequence the are on Git Wiki
  http://git.or.cz/gitwiki/SoC2008Projects

1. GitTorrent
 
Student: Joshua Roys
Mentor: Sam Vilain

2. git-statistics

Student: Sverre Rabbelier
Mentor: David Symonds

3. Gitweb caching

Student: Lea Wiemann
Mentor: John 'warthog' Hawley

4. Eclipse plugin push support
 
Student: Marek Zawirski
Mentor: Shawn O. Pearce

5. git-merge builtin

Student: Miklos Vajna
Mentor: Johannes Schindelin

6. git-sequencer

Student: Stephan Beyer
Mentor: Christian Couder, Daniel Barkalow

-- 
Jakub Narebski
Poland
