From: "Chris Lee" <chris133@gmail.com>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Wed, 3 Jan 2007 18:58:52 -0800
Message-ID: <204011cb0701031858x231df34as424b7f0c0ae4ab8b@mail.gmail.com>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
	 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
	 <20070104020652.GB18206@spearce.org>
	 <20070104023510.GC18206@spearce.org>
	 <204011cb0701031836w7d33ca8dh5de08984eec9730d@mail.gmail.com>
	 <20070104024523.GD18206@spearce.org>
	 <204011cb0701031853xd226683g85f376c206aacf3e@mail.gmail.com>
	 <20070104025659.GE18206@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 04 03:58:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2Ioi-0007Yh-9k
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 03:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbXADC6x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 21:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbXADC6x
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 21:58:53 -0500
Received: from wr-out-0506.google.com ([64.233.184.237]:54753 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932179AbXADC6x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 21:58:53 -0500
Received: by wr-out-0506.google.com with SMTP id 68so783196wri
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 18:58:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UmdjoToQ2ArXuD1oaqgoQ2oMlnlSXSPmytaxvf0KaFKEeg4zclDzlXWv90Yq2yEgCI1L3nx31TMXRjt+Wi4rRJZ3i/mfntLYBOomxWWFZxRSnqizFppzqMADFrE3uaWQJxeJ+QNtcrQF6V/S6RGSbqSEszbv4lF195ZZZ+GdRd4=
Received: by 10.90.63.16 with SMTP id l16mr6331888aga.1167879532480;
        Wed, 03 Jan 2007 18:58:52 -0800 (PST)
Received: by 10.90.80.11 with HTTP; Wed, 3 Jan 2007 18:58:52 -0800 (PST)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070104025659.GE18206@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35911>

Uh... somehow, it lost this part:

> All that's needed is to get data from SVN in a way that it can be
> fed into git-fastimport.

That's what I meant - I assume that someone already has the
svn-repo-to-gfi piece working? Where's that available from?
