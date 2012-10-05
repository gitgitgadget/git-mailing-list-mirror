From: Pascal Obry <pascal@obry.net>
Subject: Re: Ignore on commit
Date: Fri, 05 Oct 2012 15:30:05 +0200
Organization: Home - http://www.obry.net
Message-ID: <506EE0DD.6080504@obry.net>
References: <CAKRNd4w4Z-LS9O5ffkbTSZ0Guv4KCmWR=AtW3EpxQ2sSgazG=Q@mail.gmail.com> <506DEC50.7090402@obry.net> <CAKRNd4wbT_boRyFOOL_95FBW4ws8Zzz2ubVCfXuRSevzPdhW9g@mail.gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Craveiro <marco.craveiro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 15:30:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK7yw-0003zi-5J
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 15:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755760Ab2JENaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 09:30:10 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:46727 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755171Ab2JENaI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 09:30:08 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1515872wgb.1
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 06:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:reply-to:organization:user-agent:mime-version
         :to:cc:subject:references:in-reply-to:x-enigmail-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=S9/S9A0rCEO8yqEP8C2fJ7wI8z8nW97uB7nMkYve8MI=;
        b=H2370SBlIIe1IZ9BwLs+phjOSD9zVZOYw2iqcyOmKSrF7ZKuXgNRgvx3OLeB00mVPD
         hp9bHThBTjDiUAYERrx2VmSMpzLuQfKSPhQlOW3YX1ggbEFAmop1bbsJhJheJ+H3NEo3
         tCu2OjyH/HVlp+XAU+3S6ITEqiK4hlwuGuJ9LaIETyXOKqyPFxCw4VuzFEhHUbRLGuUr
         KtKL+qhYidsqUC264tWoAChuehGMVd2gu6VMHqxI6Fr5LazuPa2EguFj+fw7ITW0+/DK
         MWBwcKRIxEp1lkTzsMI2zjyW7KQR8SJGggiHicFLlxholuspiRkImFzVmMON+PxC7xCp
         Q8ow==
Received: by 10.180.102.131 with SMTP id fo3mr3482052wib.1.1349443806952;
        Fri, 05 Oct 2012 06:30:06 -0700 (PDT)
Received: from [192.168.0.100] (APuteaux-651-1-239-26.w82-120.abo.wanadoo.fr. [82.120.66.26])
        by mx.google.com with ESMTPS id f1sm2404368wiy.2.2012.10.05.06.30.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Oct 2012 06:30:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <CAKRNd4wbT_boRyFOOL_95FBW4ws8Zzz2ubVCfXuRSevzPdhW9g@mail.gmail.com>
X-Enigmail-Version: 1.4
X-Gm-Message-State: ALoCoQkj5ghcG8Rp5HHWXmNCA1N3tkz3KZteLe4pGMM50ynEFhahTvmDx7sUcFSfDbwif9TMA8yT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207104>


Marco,

> Similar but not quite; the idea is that you know that there is some
> code (I'm just talking about files here, so lets ignore hunks for the
> moment) which is normally checked in but for a period of time you want
> it ignored. 

Got it thanks! Would be useful some time indeed.

-- 

  Pascal Obry /  Magny Les Hameaux (78)

  The best way to travel is by means of imagination

  http://v2p.fr.eu.org
  http://www.obry.net

  gpg --keyserver keys.gnupg.net --recv-key F949BD3B
