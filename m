From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Documentation: git diff --check respects core.whitespace
Date: Wed, 22 Jun 2011 23:43:38 +0200
Message-ID: <BANLkTik-zxSTd-hJjsdjuc7m9XE2PLUsQQ@mail.gmail.com>
References: <1308756782-30241-1-git-send-email-git@christof-krueger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: =?UTF-8?Q?Christof_Kr=C3=BCger?= <git@christof-krueger.de>
X-From: git-owner@vger.kernel.org Wed Jun 22 23:44:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZVDk-000305-1x
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 23:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758912Ab1FVVoT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jun 2011 17:44:19 -0400
Received: from mail-pz0-f51.google.com ([209.85.210.51]:58838 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758888Ab1FVVoS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2011 17:44:18 -0400
Received: by pzk26 with SMTP id 26so825971pzk.10
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 14:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=M9etswxi+v0qCdyGQkhu0r2LaT+GsRlp3lOJu60JO7s=;
        b=iid9CsHQRMi6Kl8mk1ZbDw43VWDLS0D2Ipqns/xv4bpiomxXIEQGUD3kpxHELOWBv7
         1Z7Nqjw6o70S07oXGuJWS98+REmpjnTVE7jMl4wW6xKZB/2lQYtfNT5VpKJNVKY0psmx
         LFmjTw8MmIeG6t/RbUy4OPh1zhBvxhkOrpW/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=H4Xt49bLMRElLjaQUN3zxkbwlWqxEWpZefqWFoTI9KVLSv34moUCOLVTX91GMcG/5C
         7niU2xvQV7fBYdQ5pDBqxo3xK8K7woZoh1+FGWNQH9GSPAff/nf4paXJSn9nI/t9IEnw
         Tt37wJHlDZqVom3UBZLy5b41KlPvDiFC/H9vA=
Received: by 10.68.30.68 with SMTP id q4mr829164pbh.435.1308779058185; Wed, 22
 Jun 2011 14:44:18 -0700 (PDT)
Received: by 10.68.21.106 with HTTP; Wed, 22 Jun 2011 14:43:38 -0700 (PDT)
In-Reply-To: <1308756782-30241-1-git-send-email-git@christof-krueger.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176257>

Heya,

2011/6/22 Christof Kr=C3=BCger <git@christof-krueger.de>:
> What are considered whitespace errors is controlled by `core.whitespa=
ce`

Am I the only one who fees that "What are considered <plural>" would
sound better if phrased "What is considered a <singular>"? Is it
because I haven't heard the phrase much, or is the latter actually
better somehow?


--=20
Cheers,

Sverre Rabbelier
