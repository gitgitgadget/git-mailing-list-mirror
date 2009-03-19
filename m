From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [RFC] Colorization of log --graph
Date: Fri, 20 Mar 2009 06:48:13 +0900
Message-ID: <20090320064813.6117@nanako3.lavabit.com>
References: <20090318100512.GA7932@linux.vnet>
 <alpine.DEB.1.00.0903181228420.10279@pacific.mpi-cbg.de>
 <b2e43f8f0903190959if539048r19e972899bd2132d@mail.gmail.com>
 <alpine.DEB.1.00.0903191831590.6357@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Allan Caffee <allan.caffee@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:50:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkQ8I-0006jY-BJ
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 22:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758223AbZCSVsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 17:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756652AbZCSVsv
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 17:48:51 -0400
Received: from karen.lavabit.com ([72.249.41.33]:57597 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755157AbZCSVsu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 17:48:50 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 00E3711B81B;
	Thu, 19 Mar 2009 16:48:49 -0500 (CDT)
Received: from 7243.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id DSYJ6WVSLW3L; Thu, 19 Mar 2009 16:48:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=jI/UrltIMmAL8s6zE4eXXvpaqMjroXhyrYgECnCXwaEuejc8DkuPmxJOl/BnNGC2cEiFbucuzcx/neYK4iJt932CtrI+UPeXmi0/FcvY7QaxnmaUaVx7z7Y2aTQ66CDBu09meuTdW4vSaKw2SHZ7qn9w3bxBz4RNiGwDbubA3Kk=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <alpine.DEB.1.00.0903191831590.6357@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113838>

Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> I'd start like this:
>
> 	enum color_name {
> 		COLOR_RESET,
> 		COLOR_RED,
> 		COLOR_GREEN,
> 		COLOR_YELLOW,
> 		COLOR_BLUE,
> 		COLOR_MAGENTA,
> 		COLOR_CYAN,
> 		COLOR_WHITE
> 	};

Looking for "COLOR_RED" in the archive gives:

  http://article.gmane.org/gmane.comp.version-control.git/109676

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
