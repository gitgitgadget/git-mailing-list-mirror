From: Eugene Sajine <euguess@gmail.com>
Subject: Re: global hooks - once again
Date: Fri, 2 Jul 2010 15:30:36 -0400
Message-ID: <AANLkTikbRkkEb3UE0q47gqFH1cHvFScIjLSXhXOq_G82@mail.gmail.com>
References: <AANLkTikXJS5QCXMXgsOfkYn9cMBQV6o23tds5YG3A_OI@mail.gmail.com>
	<20100702180355.GA1770@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 21:30:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUlwk-00034o-HY
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 21:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759613Ab0GBTai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 15:30:38 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47663 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756411Ab0GBTah (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 15:30:37 -0400
Received: by qyk35 with SMTP id 35so448559qyk.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 12:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ln+YbJFGQdKfDlZlX/fb/nGxs3wH4kAAbBoUR/Pmfd8=;
        b=C+OyV5R5rkgyEbv93x8V1ly6Em2/davr4sKyH8EtkOrzdXyjaYBpbcm9vBasE3326+
         B2A7xCTBd6b1qaMcSz9zLaF5x3acVqqtsgyg9VeEnE56BtNthd9EX4HcWYJ38aF3fGgu
         9ExFMSfpArvlJmMuUH/p6NhvenkxmCoLfyzC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=d1sOvFKjoYO7ZZx7bBtvno11KQZ4ye3hEwkl6U1oMG5uv/AeJxYr57sDLH3bkKsIm+
         6TRkmCkjnS+fXYXTUvekAiTm4jeLclLbwBu8Vjb65Z2DnKhdzlil7HVE6DsSrf1rzFtP
         fnY55PV4Veau0whYF+Yy8aUvKmIW6NP827cqY=
Received: by 10.224.118.8 with SMTP id t8mr717387qaq.255.1278099036432; Fri, 
	02 Jul 2010 12:30:36 -0700 (PDT)
Received: by 10.229.212.209 with HTTP; Fri, 2 Jul 2010 12:30:36 -0700 (PDT)
In-Reply-To: <20100702180355.GA1770@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150159>

On Fri, Jul 2, 2010 at 2:03 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Eugene Sajine wrote:
>
>> I have found a thread dated March 2008 about the subject, but there
>> was no acceptable solution provided.
>
> Link?

http://search.gmane.org/?query=global+hooks&group=gmane.comp.version-control.git

Thanks,
Eugene
