From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: [ANNOUNCE] Git homepage change
Date: Mon, 5 Jan 2009 12:33:01 -0800
Message-ID: <d411cc4a0901051233v416a3b13n22811715a534872d@mail.gmail.com>
References: <d411cc4a0812151007n1be9ce95h92c8c11592ea5f9d@mail.gmail.com>
	 <20081216114138.GM12856@machine.or.cz>
	 <d411cc4a0901011040h4ab97aag20de54a6e138a4ec@mail.gmail.com>
	 <20090105164001.GA12275@machine.or.cz>
	 <a2075f4c0901051216q193057fdrc07e17b580d67150@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, git@vger.kernel.org
To: "Felipe Oliveira Carvalho" <felipekde@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 21:34:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJw9j-0000Xe-6m
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 21:34:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbZAEUdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 15:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbZAEUdE
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 15:33:04 -0500
Received: from wf-out-1314.google.com ([209.85.200.168]:18870 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbZAEUdC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 15:33:02 -0500
Received: by wf-out-1314.google.com with SMTP id 27so7764733wfd.4
        for <git@vger.kernel.org>; Mon, 05 Jan 2009 12:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fIfkcMJdox1ghSyQe3f6GCHGqTe1qsP+GqEiYDw1v6Y=;
        b=nq3V1rPjERhSbAg+wKOThlHfs2Q+5+ki74Xr9Ps+XxfoIQmkgmr/tA+RhXR34ZPAeH
         sTO8Vv07p74ZGWyeDYqlUN6zijMpdcFDmRD87UTCiJpMvarsK3g6YbrMQrP3OA++4kC7
         WHgyOnGKm8OIVtnJ3aR8LY3KKW78cgeQBSyW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=RpfhQtwflXsE1JDSX4V1u5++uBC2ZoL4ITUc7HmsV2N9TYBn4LiAJvKotyK7QxEl8L
         PNbRF+TQe5+SLmCkjqWzridQ9HOf+Eqq1sTfg7Jy89OvRIYT4o2A+cCRQUaHFRAOylfh
         9Ua+xiD55VCAJ8Aa+S8bWQAjKyr0Sx3/M0ibA=
Received: by 10.114.159.5 with SMTP id h5mr14028806wae.190.1231187581390;
        Mon, 05 Jan 2009 12:33:01 -0800 (PST)
Received: by 10.114.254.4 with HTTP; Mon, 5 Jan 2009 12:33:01 -0800 (PST)
In-Reply-To: <a2075f4c0901051216q193057fdrc07e17b580d67150@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104599>

Hi,

On Mon, Jan 5, 2009 at 12:16 PM, Felipe Oliveira Carvalho
<felipekde@gmail.com> wrote:
> On the footer we have:
> "Source for this website was forked from Petr Baudis's git.or.cz"
>
> The link git.or.cz should be changed to git.or.cz/index.html to avoid
> confusion for newcomers.

Thanks, that is a good catch - I just updated this.

Scott

>
> git-scm.com is a very good page for "git quick start".
>
> --
> Felipe
>
