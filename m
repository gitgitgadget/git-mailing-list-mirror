From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: User-wide ignore list
Date: Thu, 15 Feb 2007 20:56:00 +0700
Message-ID: <fcaeb9bf0702150556l6b5f2779re502d9fcee21bac1@mail.gmail.com>
References: <vpq4ppnvi1j.fsf@olympe.imag.fr>
	 <Pine.LNX.4.63.0702151152320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <vpqabzfsn1b.fsf@olympe.imag.fr>
	 <Pine.LNX.4.63.0702151225130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 15 14:56:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHh5m-0006Bb-7r
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 14:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773AbXBON4G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 08:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbXBON4G
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 08:56:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:63793 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932773AbXBON4E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 08:56:04 -0500
Received: by ug-out-1314.google.com with SMTP id 44so159985uga
        for <git@vger.kernel.org>; Thu, 15 Feb 2007 05:56:01 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l8xvmfmIx4ISi4FVuivHcID0a0bE2eCXDYVgkzPYAqoi391tusbK/Bp7EK0yLH3EuLLMUcGnYIMsgOK8LUURW2THT2Qvn+FYm/JbjdGcoDRTxg9DJp9gunPMLC8Ky1AWRh8Gv7LK964EgsrZbw8TXmBqVSJF/ZjEe4jl9PInxZg=
Received: by 10.114.174.2 with SMTP id w2mr985028wae.1171547760953;
        Thu, 15 Feb 2007 05:56:00 -0800 (PST)
Received: by 10.114.111.4 with HTTP; Thu, 15 Feb 2007 05:56:00 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702151225130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39828>

On 2/15/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Yes. However, you can safely call "git init" in an _existing_ repo. It
> does not overwrite existing files.

Oh.. that's enough for me :-)
-- 
Duy
