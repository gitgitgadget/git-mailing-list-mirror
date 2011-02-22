From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4] fast-import: add 'ls' command
Date: Tue, 22 Feb 2011 03:12:43 -0600
Message-ID: <20110222091243.GA20420@elie>
References: <20110222090431.GA24337@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 22 10:13:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ProIl-0005fc-Hh
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 10:12:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779Ab1BVJMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 04:12:54 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:55289 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282Ab1BVJMw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 04:12:52 -0500
Received: by qyg14 with SMTP id 14so1689379qyg.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 01:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=eK2YGWNpkKSiLAbMfZcYbEVNQU/EZZIoF8/ZPs0EhVo=;
        b=j3YSejKuSLdzBlqhGfNWCVxZw0iuBNX5KO4B+Q3K5hLCWdqeLw18r/W1xAH+8PTDSt
         q7WgBrtR2VowGX2twHHLMWefwm/VwM511SaKL0vN5EA9HFGCRkDLCSbtms7CJ04T70O/
         T2CrwM9QJxjuXPbdu1eloF/ZT87FlUYWK5dYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fdFr5vzBiO6kqp8qKT/pSFFDItevsTkUc2MgE0ncZHBGJcQllQwfWkDaXI6205xqW4
         1fkX/xU3R3bqil2jjJFXpLXasz57tNMOzDKxBia2+hTkBnNyedrZ5G9DReLFJomnFDwy
         R99DXNTxQLil7VobTms/Nq5JwLS6BmWPs0S8I=
Received: by 10.229.214.10 with SMTP id gy10mr1796713qcb.130.1298365971706;
        Tue, 22 Feb 2011 01:12:51 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id g32sm4445084qck.22.2011.02.22.01.12.49
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 01:12:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110222090431.GA24337@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167537>

Jonathan Nieder wrote:

> [Subject: [PATCH v4] fast-import: add 'ls' command]

Forgot to mention: v3 is at
http://thread.gmane.org/gmane.comp.version-control.git/166575
for those who like context.

Sorry for the noise.
