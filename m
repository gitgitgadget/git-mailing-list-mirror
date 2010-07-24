From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: rfc - Changing the way gitk and git-gui are managed
Date: Sat, 24 Jul 2010 07:57:01 -0500
Message-ID: <20100724125701.GA17634@burratino>
References: <7vocdygbw0.fsf@alter.siamese.dyndns.org>
 <20100724110239.GA13067@vidovic>
 <20100724125408.GA17481@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sat Jul 24 14:58:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OceIu-0004pE-JL
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 14:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594Ab0GXM6H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 08:58:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57845 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479Ab0GXM6E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 08:58:04 -0400
Received: by iwn7 with SMTP id 7so1153159iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 05:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Lk4E1JUerN4ZjwN++YaR8B1T88+MfbiMXYWIsDc/7ms=;
        b=Pfaz4K6vtNpLBb6LwcWT7vg0Jrj7gQ7hZvsHiW+3gzuTXFrfIqR2bgR6vhOYJ3gEIt
         O4MFsTvjY0Gyh8D9qMMFOiXmgtWwii9qys4FlOUFyDaxOVX6PWsozckuuJAeaq1PD/nX
         OIyJ6usOx4HTCcQ4nAG+YTtpvXJq+5R+G7t4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=NXDIuRjAxhAsirr22LsDneZl0COTIHl3gk0XmSFPwPqaEjmVeMv+SFYcb1rx5uniz4
         SnMRV30IeuAM7Cg8jyLbe5wyqg64c3nKZIY/o0cYSan/UTzdGKLMMib/Mm5jsz/5zpH6
         HG6wem6NVBPl/WCMIOtOIIhYgVW4o/6IaWTuQ=
Received: by 10.231.157.207 with SMTP id c15mr5186994ibx.143.1279976283718;
        Sat, 24 Jul 2010 05:58:03 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm1330028ibh.16.2010.07.24.05.58.03
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 05:58:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100724125408.GA17481@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151628>

Jonathan Nieder wrote:

> git archive hasn=E2=80=99t learned to do recursive archive yet; I thi=
nk
> the last murmurs of that topic were [1] and [2]
[...]
> [2] http://thread.gmane.org/gmane.comp.version-control.git/106788/foc=
us=3D106787

Operator error, sorry.  That link should read
http://thread.gmane.org/gmane.comp.version-control.git/140032

Good night.
