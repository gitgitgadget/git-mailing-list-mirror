From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [kernel.org users] [RFC] "clone --naked"?
Date: Tue, 17 Jan 2006 14:23:39 +0100
Organization: Universitaet Regensburg, Klinikum
Message-ID: <43CCFDEA.2997.15EA2FA@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <43CCB1D3.10309.35645D@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> (Ulrich Windl's message of "Tue, 17 Jan 2006 08:58:59 +0100")
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 14:24:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eyqoq-0007Fi-3z
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 14:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWAQNYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 08:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWAQNYM
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 08:24:12 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:12721 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S932372AbWAQNYL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2006 08:24:11 -0500
Received: from rrzmta2.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id A70A1173D9;
	Tue, 17 Jan 2006 14:24:15 +0100 (CET)
Received: from kgate1.dvm.klinik.uni-regensburg.de (kgate1.klinik.uni-regensburg.de [132.199.176.18])
	by rrzmta2.rz.uni-regensburg.de (Postfix) with ESMTP id 9FC44173D5;
	Tue, 17 Jan 2006 14:24:15 +0100 (CET)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by kgate1.dvm.klinik.uni-regensburg.de (8.12.10/8.12.10/20051031MT-1) with ESMTP id k0HDO9F9014197;
	Tue, 17 Jan 2006 14:24:09 +0100
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    17 Jan 06 14:24:09 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 17 Jan 06 14:23:44 +0100
To: Junio C Hamano <junkio@cox.net>
In-reply-to: <7v1wz7clps.fsf@assigned-by-dhcp.cox.net>
X-mailer: Pegasus Mail for Windows (4.30 public beta 1)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.98.0+V=3.98+U=2.07.112+R=03 October 2005+T=114369@20060117.131628Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14793>

On 17 Jan 2006 at 0:17, Junio C Hamano wrote:

> "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:
> 
> > ...  My original intention was that I
> > thought them to be little descriptive regarding their
> > function.  You seem to have "--bare" and "--naked". Hard to
> > guess what they really do.
> 
> True.  "A repository without an associated working tree".  I do

--rmo --repository-metadata-only?
--sdf --sans-data-files?
--rwwt (Repository Without Working Tree)?
--qdr (Quick-and-Dirty Repository)?

...

I think you have your own ideas...

Ulrich


> not know a short and sweet phrase to describe that (well, except
> "bare" and "naked", which I kind of already got used to).
> 
> Whatever word we choose to describe that, it should go to the
> glossary document.
> 
