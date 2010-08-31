From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFD PATCH] Documentation: remove git-tools
Date: Tue, 31 Aug 2010 16:23:24 -0500
Message-ID: <20100831212324.GG5911@burratino>
References: <ef9f5918c0c5254460c7ca51bd9c130ece23f4ab.1283283511.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 31 23:25:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqYKa-0001Of-Vj
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 23:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856Ab0HaVZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 17:25:18 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58808 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab0HaVZR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 17:25:17 -0400
Received: by eyb6 with SMTP id 6so238437eyb.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 14:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=cK52GSW6AKas0rFf2EtoDOpisrqfWAeaxmakOu9NTKA=;
        b=dlg93RFxClHAwShUYGCg2eH7qKaeXiUlYj/LDGjAblTy2PdGlaVLrH3/BdbgzlJ2p4
         +5v3ta4lzHXUEtnKMsC1UNMJbC2NEuFFpubTQRmn7jFOMH05GxMgVO+/QAtuKaiagCDV
         3GQubF8IZu4XtAibMWqDbwvN/Kj1ePnaberI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UyEPoUFLAJuXQ3R2icp3Mz8e6qKb8uGO7m825LkyMbgQ15/6uuARRkcintpw8vkAkP
         l37sMt5NFmmbRGiavauyBbhgS1XOD/lw51k8eRRQKMd6+8i5sxfCXqjZfKCqX1W4HBJ3
         XYPDf1z7fQ9gu8t+8DhUI3bUS03CHxr30Jqa8=
Received: by 10.216.1.12 with SMTP id 12mr614372wec.1.1283289915797;
        Tue, 31 Aug 2010 14:25:15 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id k15sm4383498wer.47.2010.08.31.14.25.13
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 14:25:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <ef9f5918c0c5254460c7ca51bd9c130ece23f4ab.1283283511.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154985>

Michael J Gruber wrote:

> git-tools.txt is outdated

Yeah.  I think it has a nice style, but it is not very useful any more.

Maybe some day someone will want to revive it by automatically freezing
the list from the wiki now and then (or similar).

> remove it from the tree.

For what it's worth,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
