From: Andreas Ericsson <ae@op5.se>
Subject: Re: impure renames / history tracking
Date: Wed, 01 Mar 2006 23:12:41 +0100
Message-ID: <44061C59.20204@op5.se>
References: <Pine.LNX.4.64.0603011343170.13612@sheen.jakma.org> <4405C012.6080407@op5.se> <Pine.LNX.4.64.0603011558390.13612@sheen.jakma.org> <46a038f90603011005m68af7485qfdfffb9f82717427@mail.gmail.com> <Pine.LNX.4.64.0603011851430.13612@sheen.jakma.org> <7v3bi2ey63.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603012105230.13612@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 01 23:13:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEZYt-0008Ch-58
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 23:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWCAWMn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 17:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWCAWMn
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 17:12:43 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:44244 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751321AbWCAWMm
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 17:12:42 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 50AF46BCBE; Wed,  1 Mar 2006 23:12:41 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Paul Jakma <paul@clubi.ie>
In-Reply-To: <Pine.LNX.4.64.0603012105230.13612@sheen.jakma.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17020>

Just to cap off my own engagement in this discussion, here's the last 
time rename detection was seriously discussed on the list:

http://www.gelato.unsw.edu.au/archives/git/0504/0147.html

If you're going to implement something you might benefit from the 
suggestions made there.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
