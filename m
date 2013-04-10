From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 5/7] completion: get rid of compgen
Date: Wed, 10 Apr 2013 06:07:33 -0500
Message-ID: <CAMP44s2qnDB7Ms4-afAa9UkMA5WNzXaFTwzOCZ=cXogZmPEiGA@mail.gmail.com>
References: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
	<1365577077-12648-6-git-send-email-felipe.contreras@gmail.com>
	<CAPig+cThNDvHWMq3h1Kh2QKNew0kqbXrfxcS05jrBh+rCLghzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 13:07:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPssT-0005GF-SY
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 13:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558Ab3DJLHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 07:07:37 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:62850 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab3DJLHf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 07:07:35 -0400
Received: by mail-lb0-f178.google.com with SMTP id q13so388657lbi.9
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 04:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ufUY9AGxyn1xdjBAEQClkVFkdYSbAOwx+sWUJH3+3jQ=;
        b=Gy1CET8WWY8ITHLab5PikuVFKY/SBBMLXxaEUbkmo4LR90UUAzSc8Z0trKFk7c2Q7z
         C9oI2+YQcMTsCoKolV43nxxhFtxpJRYHZVsefHHjfosTzeQ09Fr8/YUIroS4ux94NBvZ
         snKQxs9YpRqurfdSp4D6F4XZzZiqc/UAA7Ccv9iQKayTM+kIOJmIrJ1qSJcGApXzJHm2
         VxwdLMvyPl6mlS65Eoa0te3ZMVqpFj3aMBjjTWZvk2p+TQ/rsASy4JMWHRt9mQaYtN5t
         adHUj0xQL8TLVhwRHm21x7yumhbBJw8X8p4+V6g+YgqkMr6lnZJGxBYVdv7rIZo5piwN
         YBuw==
X-Received: by 10.112.132.166 with SMTP id ov6mr966295lbb.71.1365592053671;
 Wed, 10 Apr 2013 04:07:33 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Wed, 10 Apr 2013 04:07:33 -0700 (PDT)
In-Reply-To: <CAPig+cThNDvHWMq3h1Kh2QKNew0kqbXrfxcS05jrBh+rCLghzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220679>

On Wed, Apr 10, 2013 at 5:10 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> s/specially/especially/

http://www.merriam-webster.com/dictionary/specially

--
Felipe Contreras
