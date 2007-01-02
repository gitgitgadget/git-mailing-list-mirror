From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: www.kernel.org/git
Date: Tue, 2 Jan 2007 20:25:07 +1300
Message-ID: <46a038f90701012325w3738ddd7l841f017453272aa3@mail.gmail.com>
References: <459A05F7.4060405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, warthog19@eaglescrag.net
X-From: git-owner@vger.kernel.org Tue Jan 02 08:25:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1e1O-0000eg-0p
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 08:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932887AbXABHZL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 02:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932884AbXABHZK
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 02:25:10 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:27568 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932872AbXABHZI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 02:25:08 -0500
Received: by wx-out-0506.google.com with SMTP id h27so6004528wxd
        for <git@vger.kernel.org>; Mon, 01 Jan 2007 23:25:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VVU96DhHZICDOQ6WCijRrMRlEXPC29DxVTYNF7DN2yVvCsV7SUTZHVZ4FgKmGPBl3/5ZEsnBlW1f6vYyhmm99LfqiwukPErrhquJeu8Y0jZQZsjMrRq8sMfuoBk6E/PmLvH+HFQlYQNdfxGJatmtxxkuKy5uL6G/L0z9+5HHYyY=
Received: by 10.90.71.12 with SMTP id t12mr14178233aga.1167722707899;
        Mon, 01 Jan 2007 23:25:07 -0800 (PST)
Received: by 10.90.28.1 with HTTP; Mon, 1 Jan 2007 23:25:07 -0800 (PST)
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
In-Reply-To: <459A05F7.4060405@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35776>

On 1/2/07, Aneesh Kumar K.V <aneesh.kumar@gmail.com> wrote:
> The gitweb summary page at www.kernel.org/git have wrong git:// links.

I have just checked, and the URLs were correct. For example, I took
the git-tools url and successfully did

 git-clone git://git.kernel.org/pub/scm/git/git-tools.git

Which URLs are failing for you?

>Also the search feature is not working properly. It generates the search
> results but then immediately loads a wrong page.

This does look broken... I'll see if I can find out more.

cheers,


martin
