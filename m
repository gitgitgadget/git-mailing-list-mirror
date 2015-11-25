From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2] Documentation/git-update-index: add missing opts to synopsys
Date: Wed, 25 Nov 2015 10:13:46 +0100
Message-ID: <CAP8UFD1wSezOc29ePpr7ELD_X61VhFCsSejLO3XXhd7hgxQ5Zw@mail.gmail.com>
References: <1448434392-21983-1-git-send-email-chriscool@tuxfamily.org>
	<20151125090305.GB4696@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 10:14:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1W9w-00016V-PF
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 10:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268AbbKYJOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 04:14:18 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36446 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239AbbKYJNu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 04:13:50 -0500
Received: by igcph11 with SMTP id ph11so90001272igc.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 01:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+vyNSqFMK2eiyX4IrSXIV+K51SrNsI83N/LLTFx4S0M=;
        b=DVt+FGwWfcWnrjWVP7kvnjT0m59i77oG8OZZ955ILtrCi6irIYvOlQxdBuValVOmR1
         kOSM/BgIEzuIObR6K7SmN7gN6kHzDLtmugchiTCd++Et29PAhEJMrwFHEYSLPLVlqNnb
         aRwXsns6xqCBowd0hhlkaB6onwhi6HbSsy0EDCTapvqKLSY0+Utk3IDGGJC8KuQn8b+Q
         bcLFO/s2LN9wUIlGfsrgdqhVikWKPiXiqEnQQFI4/of4dtHxz2mIOh4rdor/9see5xIG
         u0POiL+NP98NupD2gctY4/2YyLp7sK+RaCwTPV9RMIJJVnM7eWtqDzlBMUEE+5bHyXwG
         a9ew==
X-Received: by 10.50.73.33 with SMTP id i1mr2866737igv.59.1448442826088; Wed,
 25 Nov 2015 01:13:46 -0800 (PST)
Received: by 10.36.146.68 with HTTP; Wed, 25 Nov 2015 01:13:46 -0800 (PST)
In-Reply-To: <20151125090305.GB4696@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281690>

On Wed, Nov 25, 2015 at 10:03 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 25, 2015 at 07:53:12AM +0100, Christian Couder wrote:
>
>> Untracked cache and split index related options should appear
>> in the 'SYNOPSIS' section.
>>
>> These options are already documented in the 'OPTIONS' section.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> Soon after sending the first version I realized that the split index
>> options were not in the synopsys either...
>
> Sorry, too late. I merged v1 as part of yesterday's cycle, as it seemed
> obviously correct (that's what I get... :) ).
>
> Can you please send the change as a patch on top?

Ok will do.
