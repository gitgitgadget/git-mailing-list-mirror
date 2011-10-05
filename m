From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/9] i18n: add PO files to po/
Date: Wed, 5 Oct 2011 09:39:43 +0530
Message-ID: <CALkWK0mbjweaK0_oYYQRC5d7pf7Gwcd76dYzGa9xwkikjFZCFw@mail.gmail.com>
References: <1317668297-2702-1-git-send-email-avarab@gmail.com>
 <20111003220659.GA19537@elie> <CACBZZX5uz5cdoWebYOY-Omu0drnQasJB-12DMZyZ_NX17jzhmg@mail.gmail.com>
 <7vaa9gbdyc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?Q?Marcin_Cie=C5=9Blak?= <saper@saper.info>,
	Sam Reed <sam@reedyboy.net>,
	Jan Engelhardt <jengelh@medozas.de>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 06:10:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBIo8-0000aa-Tt
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 06:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830Ab1JEEKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 00:10:06 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33708 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab1JEEKF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 00:10:05 -0400
Received: by wyg34 with SMTP id 34so1259603wyg.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 21:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/sFwVUUveFwmPzOSPjx5kM8vCb6oBdTpYy2Gw0eysd8=;
        b=TZivZrEV7FcPn0AtMmwDKTh5poYn6Jilnxm6nW4q+njATHe3NGS+//d7S8+aE3Tpam
         YPt6/gwlZFU95ANJTp2fFHJ8R0CFx2w03eoJIQeP36vuOaNmAuEkWnmtX//+enjaBMw1
         HPCZXhEn6D7XVgc9KY5RGhAzXymrnBn0P9gSI=
Received: by 10.216.80.69 with SMTP id j47mr6060710wee.102.1317787803089; Tue,
 04 Oct 2011 21:10:03 -0700 (PDT)
Received: by 10.216.51.207 with HTTP; Tue, 4 Oct 2011 21:09:43 -0700 (PDT)
In-Reply-To: <7vaa9gbdyc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182825>

Hi,

Junio C Hamano writes:
> [...]
> have been hinting me to eject everything under the current po/ directory,
> and bind that part of the tree as a submodule from another repository,
> [...]

Desirable side effect: more people will start working on improving
git-submodule :)

-- Ram
