From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit 1.1.1
Date: Sun, 19 Mar 2006 23:01:02 +0100
Message-ID: <e5bfff550603191401h2c206950w1a0e04cd50fc5370@mail.gmail.com>
References: <e5bfff550603190853m2db7bb38gecc94934c4dfb89e@mail.gmail.com>
	 <20060319214907.GA7294@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, proski@gnu.org
X-From: git-owner@vger.kernel.org Sun Mar 19 23:01:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL5xy-0005u7-Bs
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 23:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWCSWBG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 17:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWCSWBG
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 17:01:06 -0500
Received: from pproxy.gmail.com ([64.233.166.178]:32915 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750834AbWCSWBF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Mar 2006 17:01:05 -0500
Received: by pproxy.gmail.com with SMTP id z74so1476456pyg
        for <git@vger.kernel.org>; Sun, 19 Mar 2006 14:01:02 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VJi4uHaOSENkuTdrzD2zbdolk7H8UNu2ODl+lJZ52HzvPVzvZhDm9FRYbLUy3wJlhs2R7tcV49Zbz21G4f5L8IwsxG6fCCF3qtJracYhIwC6CMTdGjoGSkQTUbiggUp52RxK5whaK8kVJqI26W85dZ88GBhQiY5i7dAQTn3rRSc=
Received: by 10.65.180.1 with SMTP id h1mr577127qbp;
        Sun, 19 Mar 2006 14:01:02 -0800 (PST)
Received: by 10.64.131.10 with HTTP; Sun, 19 Mar 2006 14:01:02 -0800 (PST)
To: "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <20060319214907.GA7294@elte.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17730>

On 3/19/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Marco Costalba <mcostalba@gmail.com> wrote:
>
> > This is a maintenance release, mainly performance tweaks and small bug
> > fixes.
>
> looks good here. One small bug: when in 'patch view' mode (e.g. after
> having double-clicked on a commit), clicking on a merge commit produces
> an "Error - Qgit" window.
>

Put in this way it seems a very major bug! really not a small one!

I cannot reproduce it. Please can you give me some more info as repository
(linux tree?) and commit sha.


Thanks
Marco
