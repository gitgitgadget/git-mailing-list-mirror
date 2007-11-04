From: "Yin Ping" <pkufranky@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Sun, 4 Nov 2007 17:56:03 +0800
Message-ID: <46dff0320711040156s7a780a8dp7c76f1cbf3fd6e60@mail.gmail.com>
References: <1194004427-26934-1-git-send-email-pkufranky@gmail.com>
	 <7vd4us1jds.fsf@gitster.siamese.dyndns.org>
	 <46dff0320711021650q4e56d025q63a961176c682a14@mail.gmail.com>
	 <7vfxzoyz7f.fsf@gitster.siamese.dyndns.org>
	 <46dff0320711040125v111c75davb49e9822537f4b19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 10:56:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IocDu-0003Wm-Cl
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 10:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523AbXKDJ4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 04:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754428AbXKDJ4G
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 04:56:06 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:54828 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbXKDJ4F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 04:56:05 -0500
Received: by py-out-1112.google.com with SMTP id u77so2403991pyb
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 01:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KUn/2MzmTZKaEUZHMscH+z/32o35sdXv4NWjvVp/Iq4=;
        b=UbGFCW30+5qg9/CQ5V/M/G6VYlLKFuaYAyPWTT2t1nmOWicSUW1JdutRJkAKgY+BbnCwsllhUE5VihJ1eZeX9u/l10rXDtSnjor5xUsAiePwk/S0A0qW/2t1e903ppkg5fMNzEVkYMOxyToAxqBP6GOpqEQN4sLr3jmaK1YkiDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kZ4b82IMqIaXTbM2ram/xMsb5hGmgNO12KKeMe1iPEjS9bXZ26iaLuwprbkN2VcRNS6O6aDd8MpDQTmkNaEdb2bVkPEkBEDce2qPOQQefAyks0QFJpdpvwLSZN18A/K4Jp/pNfprlL11PmHrZmWJZK1kQzvkmaW9dzIRSSfb09U=
Received: by 10.35.79.3 with SMTP id g3mr4596060pyl.1194170163918;
        Sun, 04 Nov 2007 01:56:03 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sun, 4 Nov 2007 01:56:03 -0800 (PST)
In-Reply-To: <46dff0320711040125v111c75davb49e9822537f4b19@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63374>

On 11/4/07, Yin Ping <pkufranky@gmail.com> wrote:
> sorry, this is the reformated message of last one

Oh, I'm beaten my the mail client (gmail client will automatically
wrap line to width 80, which is not suitable for patch). Just ignore
my last messge and bear the wrapped patch line. Sorry for the
inconvience again

-- 
franky
