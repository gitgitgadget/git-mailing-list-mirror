From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/24] nd/untracked-cache update
Date: Wed, 21 Jan 2015 16:49:21 +0700
Message-ID: <CACsJy8Aei1Lbk0jPBwrg23N+Ea=w1qutDizLYVK89D4q2pxhyg@mail.gmail.com>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com> <54BEAC43.8000605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 10:49:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDrvD-0007UQ-4V
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 10:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbbAUJty convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2015 04:49:54 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:65016 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbbAUJtw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2015 04:49:52 -0500
Received: by mail-qa0-f46.google.com with SMTP id j7so31967276qaq.5
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 01:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=wBlqQZCaNrDgGWlR4az/zDtNQp1xWnR9EbrrzZSAwYA=;
        b=B+Y5cks4tqq4xn1BpeGHO/DivauZ2RQkC/aJJXX6BwQoOOFa/DmOmFfk4Nvw869rrk
         RZ1TywylUi0+8nyzAKqUdGxrAyiSYEI0IUjcgVBr6Zja/tB8jp/oGnVj7pbEPvXEJAlV
         j7OYxGI/tMB0lutYSTtsklVDWLRlxhxJNbgxrGXr4lZru8fHgzZeoabMLB+DrRPHuIoj
         WAYwzFXhT9NbpFhsl/vujRwl3Vt5cqyDGM966KAmMosTATjsO9RwnLaC3u20r1yqpTN8
         XIrLSmUdkjBgVp42rSpG1b5ui/viblg2ZXTydWJ9XdzO/jSBJuLGi06Ry86KqeJpX4Q1
         GqZQ==
X-Received: by 10.229.70.133 with SMTP id d5mr66398341qcj.2.1421833791376;
 Wed, 21 Jan 2015 01:49:51 -0800 (PST)
Received: by 10.96.137.73 with HTTP; Wed, 21 Jan 2015 01:49:21 -0800 (PST)
In-Reply-To: <54BEAC43.8000605@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262729>

On Wed, Jan 21, 2015 at 2:28 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> Do you have a commit on a public repo ?

Just pushed to https://github.com/pclouds/git/commits/untracked-cache

> pu + your serious, or master + V3 + this delta ?

it's a replacement of nd/untracked-cache on 'pu'. You may need to
merge it to master because the base is probably old.
--=20
Duy
