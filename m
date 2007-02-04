From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Don't print "rebasing" if the head doesn't change
Date: Sun, 4 Feb 2007 22:27:01 +0000
Message-ID: <b0943d9e0702041427v655abd96oe44515f0942c7812@mail.gmail.com>
References: <20070204174403.7926.29304.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Pavel Roskin" <proski@gnu.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 23:27:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDppi-0003JI-N1
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 23:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbXBDW1F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 17:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580AbXBDW1F
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 17:27:05 -0500
Received: from nz-out-0506.google.com ([64.233.162.237]:46723 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbXBDW1D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 17:27:03 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1444943nze
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 14:27:02 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TkS/w4iniXL0Gs8Y1MaQyW2RrBtre2in85d3MlJnWOMll3Zx4d4ChEWuLulr3YwejANaVFYGC0Iyz6JXZGWduNcSns5oge6kEM5+EIRuFMwx/Y4CiZPFF0pV+FhU9qsZQParqwRi7L46PwHNgL22GBN+DoLIpeJVEb00+rhGYrA=
Received: by 10.115.46.9 with SMTP id y9mr539564waj.1170628021677;
        Sun, 04 Feb 2007 14:27:01 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Sun, 4 Feb 2007 14:27:01 -0800 (PST)
In-Reply-To: <20070204174403.7926.29304.stgit@dv.roinet.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38712>

On 04/02/07, Pavel Roskin <proski@gnu.org> wrote:
> Signed-off-by: Pavel Roskin <proski@gnu.org>
> ---
> Please ignore previous version of this patch; it was buggy.

Applied, thanks.

-- 
Catalin
