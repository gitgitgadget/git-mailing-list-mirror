From: Yuval Kogman <nothingmuch@woobling.org>
Subject: Re: [PATCH] Add --ff-only flag to git-merge
Date: Wed, 28 Jan 2009 15:29:23 +0200
Message-ID: <a891e1bd0901280529v296914bdod8f33a1db4846c47@mail.gmail.com>
References: <1233147238-30082-1-git-send-email-nothingmuch@woobling.org>
	 <alpine.DEB.1.00.0901281425180.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 28 14:31:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSAVQ-0004Mj-Vn
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 14:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbZA1N30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 08:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbZA1N30
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 08:29:26 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:57790 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbZA1N3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 08:29:25 -0500
Received: by ey-out-2122.google.com with SMTP id 25so19053eya.37
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 05:29:23 -0800 (PST)
Received: by 10.86.94.11 with SMTP id r11mr1793882fgb.11.1233149363476; Wed, 
	28 Jan 2009 05:29:23 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901281425180.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107535>

2009/1/28 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> If you compare the two if() lines, you will see that you mixed style.

Thanks,

I will be fixing it here:

http://github.com/nothingmuch/git/tree/ff-only

before I send a new version, as I likely screwed up many things, not
just that =)
