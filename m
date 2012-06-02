From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Please pull git-l10n updates on maint branch
Date: Sat, 2 Jun 2012 09:26:03 +0800
Message-ID: <CANYiYbERdH4g3i6ULzFf77Dm0jJvsF3NywKVNJtPwimAN3C_uA@mail.gmail.com>
References: <CANYiYbF6aiiYMQbGM0L64yw35GOx=zNvniJrPkjs5bWmud-Y9A@mail.gmail.com>
	<7vlik623sm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 03:26:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sad6d-0000Rc-W9
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 03:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966146Ab2FBB0H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 21:26:07 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:57559 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933338Ab2FBB0F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2012 21:26:05 -0400
Received: by lbbgm6 with SMTP id gm6so2073984lbb.19
        for <git@vger.kernel.org>; Fri, 01 Jun 2012 18:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Y2m7i5VRydN7PMIJhUemkos7d2btS8dAR7zo5Mi0Tpk=;
        b=Th4uFFZ5dxYq0HXlIq3CX+8V1YPtVqx1/ygNz6BHq8HE3pKIZ2aiOEiyBk3AXeRH7M
         EKFGUpZvyQS++Ihldsba7k/Sa58ytY5b/0/SMoQd7P1sepPCzbU1JDDos2uKEBSWpSbN
         FFeDiyD6JcPccl9mKuAniy98Fm4W6bBtsGOXKmX4aLDDApVlgjqo4rfAyb5C9kMFaiCQ
         7dD+dSEco2UHxhgdO+A8kvbt52DAyGGfLKq0pcS/8kXfAIfylpMbx5TVi8Qag/w8XPDx
         0oSMm8DdBlS47wqVZFFjRFlEIz2ffgg5FfbfZww19gioLQ1n2v/5/cczrNF9UGUOJoj7
         7mKw==
Received: by 10.112.29.233 with SMTP id n9mr2777074lbh.91.1338600363581; Fri,
 01 Jun 2012 18:26:03 -0700 (PDT)
Received: by 10.112.10.161 with HTTP; Fri, 1 Jun 2012 18:26:03 -0700 (PDT)
In-Reply-To: <7vlik623sm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199031>

2012/6/2 Junio C Hamano <gitster@pobox.com>:
> Pulled both maint and master. =A0Thanks.

As usual, after Junio pulled git-l10n updates, I would try to generate =
new
=91po/git.pot'. This time only 'po/git.po' in master branch changed:

    l10n: Update git.pot (5 new, 3 removed messages)

    Generate po/git.pot from v1.7.11-rc0-100-g5498c:

     * 5 new l10n messages at lines:
       635, 639, 1203, 1208, 3946

     * 3 removed l10n messages at lines:
       1194, 3158, 3936

L10n team leaders could update your 'X.po' and start new round of l10n.

--
Jiang Xin
