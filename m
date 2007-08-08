From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Submodules
Date: Wed, 8 Aug 2007 21:47:53 +0100
Message-ID: <200708082147.57822.andyparkins@gmail.com>
References: <a1bbc6950708071537xfa6b9a0ne8cf66e345fa31b4@mail.gmail.com> <7vhcn94y9l.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0708082138520.21916@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, skimo@liacs.nl,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 22:48:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIsRr-0000xx-I1
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 22:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758305AbXHHUsE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 16:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757921AbXHHUsE
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 16:48:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:3655 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757694AbXHHUsB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 16:48:01 -0400
Received: by ug-out-1314.google.com with SMTP id j3so266249ugf
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 13:48:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=niec/AaRXgAM91G9+FHPTDi9NhHTJXiimY+IckMRCC281nkG5ChKo0JQE1wzgsY/pTsSEanNEwGGyKiqKCvo0k1p6pZFlr/OUV9HiGyvT8aP1/gt7rRYuXCShjZ59itP9yKLU8uvz+3eLrk3uLtvnNwhjmy0556ZuQ9GTzwdE1w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ohT3fDUjcra3TR5hUbZchdGLyHMMzWQ6TYMxeSdz/XR2o/7LrHFoOJLd2Kmer3E5pCIklHUhGHJV6PV26otNWuX/iGwKVWxgZ+pRSojzKEURG6L7ugZiLvo8RK+/l0acFuiihReHjn+S8Cq4xe9KNvwuP3f0xR+qqXLQNHBzJvg=
Received: by 10.67.89.5 with SMTP id r5mr1789616ugl.1186606080362;
        Wed, 08 Aug 2007 13:48:00 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTPS id d26sm1868013nfh.2007.08.08.13.47.58
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Aug 2007 13:47:59 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0708082138520.21916@wbgn129.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55362>

On Wednesday 2007, August 08, Johannes Schindelin wrote:

> Also, I realised that git is not really happy unless you install
> alternates pointing to the object stores of the submodules.  Shouldn't we
> make this my default (for example in "init")?

I use submodules on a daily basis and haven't experienced this at all.  
Would you mind saying a little more about this problem?


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
