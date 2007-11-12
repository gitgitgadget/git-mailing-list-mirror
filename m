From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git packs
Date: Mon, 12 Nov 2007 17:46:28 +1300
Message-ID: <46a038f90711112046y300dcd8amd37445895863557@mail.gmail.com>
References: <F6DD8DCD-416B-4DDF-B384-7213C9ED5565@mac.com>
	 <00593593-E943-4DA0-AA9B-FDBB866E7EFB@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: bob <kranki@mac.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 05:46:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrRCA-0006Iq-Cx
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 05:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149AbXKLEqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 23:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754652AbXKLEqb
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 23:46:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:51311 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765AbXKLEqa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 23:46:30 -0500
Received: by ug-out-1314.google.com with SMTP id z38so681422ugc
        for <git@vger.kernel.org>; Sun, 11 Nov 2007 20:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=elQn0CQSDKd013csTkTlXLYdeKbKLDyftv7DdzUWwOI=;
        b=UoMKo25DzesR+R8H11/M6g027GfvWjWhh91kpfzNNLw9oeTlmQ5UQx9OA0X1EjcRqgDQv4U7vvx9n9V4l3EZw9RXT2TxCvkqxdwB/9sAwi+XUoNrOf++3UgbrTm6FHG1xhfAcyMCt9Jop9bo4UUy57qX5v8pWe8Z+RzT4JnWiZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L/p79iL16Pp/tdL+jWJxoGjH9jL5J/2aTMOtQKpfjzDsROXtgd+tI8pvENcLIwrC/5o2tOEWDSHzlvSWCgcQeM2R0txA3aE8EzIxCW8mvDKg4OzMuOY0dGLFqZ/wd2cc1Fd2fnZtlStgvUeQ+gb6hSv+FRqpEYRjxMjs4PyliUU=
Received: by 10.67.20.19 with SMTP id x19mr1851322ugi.1194842789045;
        Sun, 11 Nov 2007 20:46:29 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Sun, 11 Nov 2007 20:46:28 -0800 (PST)
In-Reply-To: <00593593-E943-4DA0-AA9B-FDBB866E7EFB@mac.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64560>

On Nov 11, 2007 6:40 AM, bob <kranki@mac.com> wrote:
> I am now going to split out the jpg(s), pdf(s)
> and (.mov) files from the repository  and just
> manage them external to the git repository
> which will fix my git problem.

For version-less synchronization of large files I'd suggest unison (as
a smarter rsync, it's excellent) or the newfangled tra.

hth,


martin
