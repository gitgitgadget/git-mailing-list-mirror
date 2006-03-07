From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cvsimport woes
Date: Tue, 7 Mar 2006 16:06:39 +1300
Message-ID: <46a038f90603061906n6ef7f48dw910661e33496fec3@mail.gmail.com>
References: <44094618.6070404@asianetindia.com>
	 <46a038f90603060124h4ea1c3c6gaa5d8b52ed311230@mail.gmail.com>
	 <46a038f90603060137o758ea7ch6c40652ad86a102a@mail.gmail.com>
	 <440C68B9.9030305@asianetindia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 04:06:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGSX7-0005u2-Bb
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 04:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbWCGDGl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 22:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbWCGDGl
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 22:06:41 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:8552 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932633AbWCGDGk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Mar 2006 22:06:40 -0500
Received: by wproxy.gmail.com with SMTP id i20so1303587wra
        for <git@vger.kernel.org>; Mon, 06 Mar 2006 19:06:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DY/Rk6+iG4jtT2p0OoP+X3mrBOdKEjKxqWyIvagUgvS+i/mDsvU/eiUimLqX7p9zPtQ3P3ldbbWusfi2aRwKV5uPTepaU/5A4HDjqeSPjYPwHnglHApm3APVtveamJteQDP53Mrg+iOnKYhT/FZb8yjB7dKUS8qaFAEeZTk04EM=
Received: by 10.54.92.13 with SMTP id p13mr56479wrb;
        Mon, 06 Mar 2006 19:06:32 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Mon, 6 Mar 2006 19:06:39 -0800 (PST)
To: "Rajkumar S" <rajkumars@asianetindia.com>
In-Reply-To: <440C68B9.9030305@asianetindia.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17315>

On 3/7/06, Rajkumar S <rajkumars@asianetindia.com> wrote:
> You can use this script to reproduce this problem.

Rajkumar, does it work better if you add "sleep 10" before each
invocation of git-cvsimport?

cheers,


martin
