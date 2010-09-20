From: bill lam <cbill.lam@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.16.1
Date: Mon, 20 Sep 2010 10:30:36 +0800
Message-ID: <20100920023036.GB2548@debian.b2j>
References: <20100919183556.GA22302@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Sep 20 04:31:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxW9x-0003mK-8n
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 04:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373Ab0ITCbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 22:31:05 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:50236 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755023Ab0ITCav (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 22:30:51 -0400
Received: by pxi10 with SMTP id 10so1030910pxi.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 19:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QvHmyf5iNM9E6YxN5jCFpd5x/AGEMRoYW2t4euMVWj4=;
        b=H+E1vZUCFAdKiIH/QpsGdP2I3fwVcQsebq0FjVW1EZIQ08NL9G3qu+gDDsPkE6tfze
         x4VIW4FFyX6uyECKweOGxLBIOvse8XKPwFe5p4k/bPreUh/cw2EVcMof2Cz2N7vYTmlv
         ZbLG0yMel1fdOk2KrtxowKHHUTK5JvJovxQXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Eu8xf6QOXgbJ3D0BJ0Ch2Zufh7PHCfGOdRJ9zQ61UOLOq0UH28z0SBGsZpTXtK/0K8
         mROxH0KD7dKVW/4TWKSIOe+Yjvql38lL15ncQy4nJpsoLYH4PIx/ACSyYoyaGIYVGEeF
         lfRZVrQ+yJat9VxNGQUUaXO1f6W3S7lIKZ94M=
Received: by 10.142.142.8 with SMTP id p8mr7061124wfd.316.1284949851222;
        Sun, 19 Sep 2010 19:30:51 -0700 (PDT)
Received: from localhost (n11649177239.netvigator.com [116.49.177.239])
        by mx.google.com with ESMTPS id k23sm12536037waf.5.2010.09.19.19.30.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 19:30:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100919183556.GA22302@diku.dk>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156547>

Thanks for update.

BTW, do you plan to port tig to windows?  Although I seldom use window but
I know ncurses is available as pdcurses.

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
