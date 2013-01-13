From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: missing objects -- prevention
Date: Sun, 13 Jan 2013 06:27:56 +0530
Message-ID: <CAMK1S_gMsxuP-L=+1kcM2Zmh=vzpYqdCm+Rder8jnChYhuYVOw@mail.gmail.com>
References: <CAMK1S_jpofLRO02XTYryOP98g7rnrJXs7Mh2zvi=SoVUAs0dUw@mail.gmail.com>
	<20130111164202.GB5219@sigill.intra.peff.net>
	<CAMK1S_jN7=Antz-5D7yf0KV8m-YEy93tZP_zziTXPDzbdyjUrw@mail.gmail.com>
	<20130112131358.GB21875@sigill.intra.peff.net>
	<CAMK1S_iKARYqi_Dv90og0No7NN=WxFg+ixmRvnkvfdrcOi1r=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 13 01:58:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuBu5-0006i0-Vu
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 01:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753844Ab3AMA55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 19:57:57 -0500
Received: from mail-ia0-f169.google.com ([209.85.210.169]:57895 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab3AMA54 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 19:57:56 -0500
Received: by mail-ia0-f169.google.com with SMTP id j5so517601iaf.28
        for <git@vger.kernel.org>; Sat, 12 Jan 2013 16:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YtJIgWaHwwOIO/FXEk6KbZKHSzIFayVYzMdBXmX0PSY=;
        b=YLxIqsNzsQvSqU4Gg5neGxc/58ID9dOSuAFxRmZYaC26L8Pom8y+LH+32ZyXbMChqd
         4JGWa0by+ccsrx2A+Cwt7yeX4RLt3AEy09TkI0Uek+DhEjKtnxMazONNK2GlJQcCJHmi
         iNw5x2T6FDxmkOUCipoGhrAhNLwmnWSJ5T2i0rdXwf1ZiAEB3jTk60C9xHdCSmI118ro
         YOdJRykm+WX38J+ac7S1In/63zwZKF2FWFyxzqQBW+a1qbV2+G+CVm9JCeuPlYumXnVW
         AsbXUQE+qgSik3iB0wLQLG4ukVx85YaMaKB+LYoWamPl+R/dVoytdBgx+S+ZpWB/2+UK
         J7og==
Received: by 10.50.151.211 with SMTP id us19mr3256574igb.84.1358038676299;
 Sat, 12 Jan 2013 16:57:56 -0800 (PST)
Received: by 10.50.30.164 with HTTP; Sat, 12 Jan 2013 16:57:56 -0800 (PST)
In-Reply-To: <CAMK1S_iKARYqi_Dv90og0No7NN=WxFg+ixmRvnkvfdrcOi1r=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213318>

Uggh...

On Sun, Jan 13, 2013 at 6:26 AM, Sitaram Chamarty <sitaramc@gmail.com> wrote:

> the object store -- the old ones were not dereferenced).

I meant *un* referenced of course :)
