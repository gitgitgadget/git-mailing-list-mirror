From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [L10N] please review a batch l10n update for Git 2.2.0 final
Date: Thu, 20 Nov 2014 07:31:16 +0100
Message-ID: <CAN0XMOLZw+btduQkQwMLykYFgFuZzTfMwnexyGR0FBdbG=qFmA@mail.gmail.com>
References: <CANYiYbFrNCqxfrcaOWjeEZ2no=DRHVoDic8Qg989=U_VUTWiWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 07:31:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrLH1-0003xE-6w
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 07:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbaKTGbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 01:31:19 -0500
Received: from mail-wi0-f179.google.com ([209.85.212.179]:58280 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbaKTGbS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 01:31:18 -0500
Received: by mail-wi0-f179.google.com with SMTP id ex7so4216703wid.6
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 22:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YqFo0Zb6XrO/3i8Le4qAm7947rDhbDuArERmiSU60ek=;
        b=T21zrGMyjQbfvK+KxmAQJJlNMtglGie4vDq4gV0XO+5F1+MfbN7iHDbq8yXNpjW8Ev
         xBaqw2FOa5PygLxhgPZ97de6vWQ0LezXfG+twwiFtzeIreJbOReFj1mpV2upUnDOIta9
         QCBvrI3EMYNkGuomhu+R74IFgO8oNppzOw06s6U8eTn6Gcmkc0kPPjVrl412Q8fUtXyZ
         5O/N17Rku6qGdlT+GlwtmLN5fu7ibiG7MF3um+5XuvqfcjTddH/txDsfnVbLjQJjvhXR
         O2FGTydn+JtGiLFnUGbVS+z60SAzhG7Gk57Nc+eQMDN8N+c3L5kQLERWiMUXin6Vh65C
         quwA==
X-Received: by 10.180.91.227 with SMTP id ch3mr12281172wib.17.1416465077012;
 Wed, 19 Nov 2014 22:31:17 -0800 (PST)
Received: by 10.194.35.137 with HTTP; Wed, 19 Nov 2014 22:31:16 -0800 (PST)
In-Reply-To: <CANYiYbFrNCqxfrcaOWjeEZ2no=DRHVoDic8Qg989=U_VUTWiWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> NOTE for Ralf:  After I updated de.po, there are 3 fuzzies instead of one.
> I can only fix one of them.
>

I just send a pull-request to you. It seems I have forgotten one git.pot update.
Sorry
