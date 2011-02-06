From: Pat Thoyts <patthoyts@gmail.com>
Subject: Re: [PATCH] git-gui: instead of defaulting to home directory use
 working directory
Date: Sun, 6 Feb 2011 23:01:34 +0000
Message-ID: <AANLkTin34B8m-UGkHU80hOZdvBx-os_zDx7yFsHs9caJ@mail.gmail.com>
References: <20110206172244.GC47941@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pat Thoyts <patthoyts@googlemail.com>,
	Jens Lehmann <jens.lehmann@web.de>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Feb 07 00:01:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmDbx-0007ZA-TZ
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 00:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045Ab1BFXBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 18:01:36 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60591 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759Ab1BFXBg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 18:01:36 -0500
Received: by bwz15 with SMTP id 15so4404926bwz.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 15:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ywdl+97UTtbVGbfESm4r0wT3FELW229KShhlp3wRRwY=;
        b=DxAHaVRRqibLIsNLkeOpYD5pg6NxuKVACMOO256yqA4LLJHI6Vbi9rmGuUwY5v1/3t
         zdGdi4rKegVEOe26TvvEOwldsuqEcPnZMjmoNQfMxExmcaL8laHu56WcIrrHgF0r2WwO
         sVl6eYtHOise7/ww0Z80YaGhn8yf1cIM6g9Zk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SjdSWTozg95OpV4F7yzIu/W1VipOW2BqWOlQvX5Augbelqolt5FIexbztX10M7o8++
         AoBB1/7vbNjB5S499QxfX86vsBmsBgBCgOUPdfpff0Gq5wyNbs/ytjtEhEosLYp1m8DN
         o/iZd/r617ZfZXte3IEpAMB3AVE13l2gzzFEk=
Received: by 10.204.71.82 with SMTP id g18mr14604959bkj.166.1297033294890;
 Sun, 06 Feb 2011 15:01:34 -0800 (PST)
Received: by 10.204.118.12 with HTTP; Sun, 6 Feb 2011 15:01:34 -0800 (PST)
In-Reply-To: <20110206172244.GC47941@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166211>

All three patches are fine - thank you.
 git-gui: instead of defaulting to home directory use working directory
 git-gui: scroll down to default selection for push dialog
 git gui: keep selected branch when remote is changed in push dialog
all applied.
