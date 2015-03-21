From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzFdIGwxMG46IGRlLnBvOiB1c2UgImJsYSDigKYiIGluc3RlYWQgbw==?=
	=?UTF-8?B?ZiAiYmxhLi4uIg==?=
Date: Sat, 21 Mar 2015 22:21:19 +0100
Message-ID: <CAN0XMO+JLfzkYwP5rKkT6RyLJ-XuH1k=9vKmi1X0xb1SjTOdvg@mail.gmail.com>
References: <1426942357-5618-1-git-send-email-phillip.szelat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
	=?UTF-8?Q?Magnus_G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>
To: Phillip Sz <phillip.szelat@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 22:21:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZQpi-0003VH-Cb
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 22:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbbCUVVV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2015 17:21:21 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:36736 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbbCUVVV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Mar 2015 17:21:21 -0400
Received: by wetk59 with SMTP id k59so107825235wet.3
        for <git@vger.kernel.org>; Sat, 21 Mar 2015 14:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=27NfV5yOfQFhN5XNuqKZEZR9EjPWN6uXWIr8XoKq/zw=;
        b=YmMQsgbsR76Y49AKHUFQZH7coPSmIi5LbbDxmriz6G9WgEX+k80zstW1p0+WVABX4d
         LLWLaTgx0hpGRncOXqjekcpeSlVBmdhuxpQq9uZnNeTGUiribyDj7bF5LgWbuKY1u4YZ
         OLp4TKFW9whypCg5onJfDQoyLbB36oC/O7Z6bXx24SRRPcS/WSQ09xBorGPlBgYUrWds
         eRFe579H5yAfCB8xa6v0qv1mm5KOmAknhpUMjeNiugb25+XLqB+oKmdWgcuo9BFhxEFe
         O6rt+O6P5ebprD2gHavZENQrQJ4gaJ3KKxheqT5O9jWtVvGKvZg35iXi9R6CPaI+j6/M
         TuWw==
X-Received: by 10.180.105.136 with SMTP id gm8mr7153664wib.13.1426972879840;
 Sat, 21 Mar 2015 14:21:19 -0700 (PDT)
Received: by 10.194.72.5 with HTTP; Sat, 21 Mar 2015 14:21:19 -0700 (PDT)
In-Reply-To: <1426942357-5618-1-git-send-email-phillip.szelat@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266035>

Am 21. M=C3=A4rz 2015 um 13:52 schrieb Phillip Sz <phillip.szelat@gmail=
=2Ecom>:
>
> I think we should use it like this, as most open-source projects do.
> Also we should use a space before the three dots as per http://www.du=
den.de/sprachwissen/rechtschreibregeln/auslassungspunkte
>

I don't think this rule of ellipsis applies here as the dots are meant
to be a pattern to tell users that an argument can be passed multiple
times.
