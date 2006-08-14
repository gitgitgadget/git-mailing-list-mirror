From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 00/28] clean-ups of static functions and returns
Date: Mon, 14 Aug 2006 13:47:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141345530.19669@chino.corp.google.com>
References: <Pine.LNX.4.63.0608141314350.19383@chino.corp.google.com>
 <ebqmlk$npt$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 22:48:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCjMG-0003V6-NV
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWHNUsK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932733AbWHNUsJ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:48:09 -0400
Received: from smtp-out.google.com ([216.239.45.12]:45726 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932685AbWHNUsI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:48:08 -0400
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out.google.com with ESMTP id k7EKm2qv018418;
	Mon, 14 Aug 2006 13:48:02 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:in-reply-to:
	message-id:references:mime-version:content-type;
	b=E8FQeFP18wWC/hS8FAz8ZxY/2TqXsIxHsBE6x/ij5/8s/T6z4CAQvslepcndCgZ+f
	1buR9hdJ0ahb9ApG8sTDQ==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps78.corp.google.com with ESMTP id k7EKltwK017194;
	Mon, 14 Aug 2006 13:47:55 -0700
Received: by localhost (Postfix, from userid 24081)
	id 4A3D287D71; Mon, 14 Aug 2006 13:47:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 0ECBE87D70;
	Mon, 14 Aug 2006 13:47:55 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ebqmlk$npt$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25410>

On Mon, 14 Aug 2006, Jakub Narebski wrote:
> Could you please make description of patch series email to be parent
> (ancestor) of all patches emails, i.e. for patches either to be 
> chain-replied to introduction email, or all be replies to introduction
> email.
> 
> It makes for easier reading/viewing/applying/ignoring the series.
> 

Sure, but you might also want to include this request explicitly in 
Documentation/SubmittingPatches.

		David
