From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Make git-push silent
Date: Thu, 21 Oct 2010 13:38:50 -0500
Message-ID: <20101021183850.GC11501@burratino>
References: <20101021181906.GA28700@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Enrico Weigelt <weigelt@metux.de>
X-From: git-owner@vger.kernel.org Thu Oct 21 20:42:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9065-00072g-Fj
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 20:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757282Ab0JUSmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 14:42:36 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:59981 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312Ab0JUSmf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 14:42:35 -0400
Received: by pxi12 with SMTP id 12so10288pxi.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 11:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jXn16H+RprPlE1sIJanZhBFA1jdtazjLWeTuQP6R7yo=;
        b=lRT6+Ho1Pljg+wVGWSJ8pnNtKF38FsvK6Rwnh9GQcXvLzt3gTl7dhsBPHWt14oL23e
         y/LWZ77GjVAH5Dz+XVjWo+N+VrpWY/FoyUxXGOly37+uaLuRq1cbrsrgXQPSiV/kuVvX
         GNZEBCuy1/OgCd+sN0R8zGr8LzBAJNRupiW9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AzDBK6XFDj4N7cVGZO/MJRSw5A/SgRcIi3ijANV8JHadexwDY5SrV1zNV9V5UPCNr2
         hp1hCSworSbK1+ci3SHQyrwEAONC0gCIP7vLwVyj4x8IqV9TIku7+Wtf1b0LHamMPept
         hC4ZtXQdQc4W8eWvoqdPxPI+S5C7FlPuubr9o=
Received: by 10.142.252.11 with SMTP id z11mr1155435wfh.204.1287686555303;
        Thu, 21 Oct 2010 11:42:35 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id z36sm994733vbw.17.2010.10.21.11.42.33
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 11:42:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101021181906.GA28700@nibiru.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159533>

Hi Enrico,

Enrico Weigelt wrote:

> is there a way to make git-push silent in a way that it only 
> outputs something in case of error ?

http://thread.gmane.org/gmane.comp.version-control.git/153558

Cheers,
Jonathan
