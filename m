From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: real git pull grief
Date: Tue, 15 Jan 2013 16:20:46 -0800
Message-ID: <20130116002046.GF12524@google.com>
References: <CADq_mb8LwzbjvaXGCR-6TZbTShf2nzw5wtNZ66_XmOM00-=xzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Vee <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 01:21:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvGkv-000446-U9
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 01:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163Ab3APAU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 19:20:57 -0500
Received: from mail-da0-f42.google.com ([209.85.210.42]:49964 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932168Ab3APAUv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 19:20:51 -0500
Received: by mail-da0-f42.google.com with SMTP id z17so288236dal.1
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 16:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=M4AQJoz6dB8/S92BSykbBaFkJRahUHZCHc7l7s5YTtI=;
        b=aWPMmG3KB0yIUBZ1gJ/NmiBWO+KvRSVVhIZEl9bfUw2pCp3OPiVFWdJ3+dMyFlLGMF
         UIRfPVIMxVg7g1jwTfDc5Yoz07mif/eU1cBcNO+903MRlyA9lI6BtWdU7+4rDac9d4zb
         vpiV/TG1nR4qxno4jP4+Ca62ScETgeJPj+PA+zn8sZAnPphJ9OLiG+kr7+LrPiXQqxwE
         O9PDeA9xli/iFDNuz5NflItmE3uzStR7jxkBamfySs3fgKgVbKizZbZDspj4Q5odxgFG
         I8TDx+EZKJSkN3gGKri4+Ts+GUOeTcPC1OPfd1p8gMltG5/ALtymyqK75vU7I3dW5qie
         vg/Q==
X-Received: by 10.68.241.232 with SMTP id wl8mr268550887pbc.144.1358295651490;
        Tue, 15 Jan 2013 16:20:51 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id d1sm11762643pav.6.2013.01.15.16.20.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 16:20:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CADq_mb8LwzbjvaXGCR-6TZbTShf2nzw5wtNZ66_XmOM00-=xzQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213696>

Hi Jay,

Jay Vee wrote:

> I HAVE NOT CHANGED THIS FILE.  It is telling me that my local
> changes.... huh? I have not changed or modified the file.
>
> ----
> When I do a $git status I see a lot of other files that begin with:
>
> #       modified: ....
> <many of these>

Two questions:

 * what does "git diff" say?
 * do you use Eclipse's git integration?

Curious,
Jonathan
