From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: How to make gitk not overwrite my selection?
Date: Thu, 6 Mar 2008 12:00:02 +1300
Message-ID: <46a038f90803051500w508b3093l7061d44828600a5d@mail.gmail.com>
References: <47CD6D1C.1080202@gmx.ch>
	 <20080304230306.GA18246@sigill.intra.peff.net> <47CF223A.60507@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Paul Mackerras" <paulus@samba.org>,
	git@vger.kernel.org
To: "Jean-Luc Herren" <jlh@gmx.ch>
X-From: git-owner@vger.kernel.org Thu Mar 06 00:01:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX2bg-0001Kc-Og
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 00:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765712AbYCEXAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 18:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765730AbYCEXAI
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 18:00:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:12167 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765731AbYCEXAG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 18:00:06 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3520131ugc.16
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 15:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=PoH0z2CO/lNFwqy4WDbMlS7nufewj2xlyyHD74UYjkk=;
        b=hMqjEoc42ITgTTa96HSp0v1l53EQ4TUuN2jUelPQ3OUdRAjY44gdCZ3sC5oNUJYEH0esmdeBZi0ZOsOfLHufoNq5P4Jr8D9yBukwda6nmhqN4l2b1JDogqUk6gJs0Dz7wg8YmUKV12ITmMaxD+rvVw+bY+v44rz/Z75SPuU74dw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q7cgXf8L24pD/Rz0NWkbpT3iElzQGdLyji5GdsOF99tCBXxyVXg9uIGERD+UkxxKqBk11ai49sYjzaIiDmtiKH8CqKl/gJuXDx9zSAistDlpKi+upkNrHPQ7VBGXOQ6eNPw90Eghn7SqB3FGWelf3RI1iv0ULCtM3FgJ+D7jKOY=
Received: by 10.66.220.12 with SMTP id s12mr115634ugg.15.1204758002478;
        Wed, 05 Mar 2008 15:00:02 -0800 (PST)
Received: by 10.66.252.6 with HTTP; Wed, 5 Mar 2008 15:00:02 -0800 (PST)
In-Reply-To: <47CF223A.60507@gmx.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76286>

On Thu, Mar 6, 2008 at 11:44 AM, Jean-Luc Herren <jlh@gmx.ch> wrote:
>  Thanks, I don't know tcl either, but the patch seems to work great
>  here.

Taking it too here. Welcome option.



m
