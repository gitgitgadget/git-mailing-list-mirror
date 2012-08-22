From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2012, #06; Tue, 21)
Date: Wed, 22 Aug 2012 20:51:01 +0700
Message-ID: <CACsJy8CVe53URvheehhGnxpOdhhidd67UY6OD5KD-X-f9hGBQg@mail.gmail.com>
References: <7vk3wrc04o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 15:51:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4BLO-0006FC-SE
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 15:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380Ab2HVNve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 09:51:34 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49769 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab2HVNvc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 09:51:32 -0400
Received: by ialo24 with SMTP id o24so876235ial.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 06:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4RZJ6UoacRrb+Qvf3qAIxSe9lZSWVSV65viNN9REM3I=;
        b=ncUXaCBjACDcI7WASUFow/JsdrXxVfnW7EH+3BAo/q1tg1FstNW7+n8CzLN0OKQVI7
         zFzLCM40wNTqPgpqfTUF2aFwOVT492YZhEYm6PbwScgdTsuGW2dFPzAXn789Hc0bSA0k
         cih5EF7WrMGpJ5NHei794bCAiLPHcf5cJ7cX1hgRKpR7sh0O0M//qCvoKD5u9a5iEqVQ
         ynIyFtls8aVJwPJZvvWe77VBx1lMqDu5oXVVZyoULYeedtt0o/GxoOIUw95Yfin/ai1H
         qX5z9Tbk53cTV2fUJDy+947ltL+9S7CvrvzvhWXwRjYEmYlkMPjI7aRpdyJay0l3OXBG
         yw3A==
Received: by 10.50.220.194 with SMTP id py2mr2300753igc.15.1345643491787; Wed,
 22 Aug 2012 06:51:31 -0700 (PDT)
Received: by 10.64.35.12 with HTTP; Wed, 22 Aug 2012 06:51:01 -0700 (PDT)
In-Reply-To: <7vk3wrc04o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204016>

On Wed, Aug 22, 2012 at 6:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/i18n-parseopt-help (2012-08-20) 54 commits
>  - i18n: shortlog: mark parseopt strings for translation
> ...
>  - i18n: mark "style" in OPT_COLUMN() for translation
>
> A lot of i18n mark-up for the help text from "git <cmd> -h".

It's a 66 patch series, but only 54 here. 55/66 [1] to 66/66 [2] did
not make it to your inbox?

[1] http://article.gmane.org/gmane.comp.version-control.git/203827
[2] http://article.gmane.org/gmane.comp.version-control.git/203838
-- 
Duy
