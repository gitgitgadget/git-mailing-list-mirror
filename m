From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH v2] gitk: Remove mc parameter from proc show_error
Date: Sat, 16 May 2015 22:30:05 -0600
Message-ID: <CAMMLpeR7a6UUoODs6NN6Vjtvss4pr6VRgC1Huv0R33oUmraxBA@mail.gmail.com>
References: <1431372401-8750-1-git-send-email-alexhenrie24@gmail.com> <20150517005227.GA21039@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bernt Hansen <bernt@norang.ca>,
	Git mailing list <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun May 17 06:30:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtqDg-0004OB-S9
	for gcvg-git-2@plane.gmane.org; Sun, 17 May 2015 06:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbbEQEa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2015 00:30:28 -0400
Received: from mail-wi0-f195.google.com ([209.85.212.195]:33357 "EHLO
	mail-wi0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbbEQEa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2015 00:30:27 -0400
Received: by wivz2 with SMTP id z2so4908175wiv.0
        for <git@vger.kernel.org>; Sat, 16 May 2015 21:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AF0n34K/i8liT0SRYDY44NsGTJ6eXZ0GH7NnnP+HFIc=;
        b=m18iZ2NcSffeFGoovjhdwDapEY89CA3LKntHGJ2PkDV6gCvi6GNttKXi2irDrj40Mv
         XtPiUCR8h32OCbPRQK92q09AWxJiOGnHzfBKPinKhayP2UtPC+wJ117ipyjvsZm8I+5c
         Q8rx4kN2pwxasn7OB2rMaIWAktHcGm0umtKmZrbquUfmKEEZciP2KCpBnVefooqX979e
         W4ni1DnFUGpecjvnRoeGFmuhcMp7ylodo0CdWpCl0EPiPh4Lk2G2uKPmHr63PtbHRtKm
         vcq4NF19yLDjCukq3ThkQIJuQSlBkh8l4izEf1dponnZeHlM6G2VaBZdUG8HmRu241qp
         bWBg==
X-Received: by 10.194.188.107 with SMTP id fz11mr31150825wjc.98.1431837025780;
 Sat, 16 May 2015 21:30:25 -0700 (PDT)
Received: by 10.28.182.84 with HTTP; Sat, 16 May 2015 21:30:05 -0700 (PDT)
In-Reply-To: <20150517005227.GA21039@iris.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269210>

2015-05-16 18:52 GMT-06:00 Paul Mackerras <paulus@samba.org>:
> Thanks, applied.

Thank you! (For being patient and reasonable with me on this issue.)

-Alex
