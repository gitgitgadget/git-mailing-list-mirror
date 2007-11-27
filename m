From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: git bug/feature request
Date: Tue, 27 Nov 2007 11:57:24 +0100
Message-ID: <7A14A564-C424-4ACC-A860-A11DCC38C9A1@lrde.epita.fr>
References: <200711271127.41161.gapon007@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gapon <gapon007@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 11:58:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwy8W-0006Zs-Ok
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 11:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909AbXK0K5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 05:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755732AbXK0K5d
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 05:57:33 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:45334 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272AbXK0K5d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 05:57:33 -0500
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1Iwy8B-0005nM-Hn; Tue, 27 Nov 2007 11:57:31 +0100
In-Reply-To: <200711271127.41161.gapon007@gmail.com>
X-Gpgmail-State: !signed
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66184>

On Nov 27, 2007, at 11:27 AM, gapon wrote:

> * yes, i know that this scenario is "incorrect" but... it's  
> possible and
> therefore i think it should be somehow handled - i tried a similar  
> one with
> hg and bzr and i like their behaviour more


Would you mind describing the behavior of hg and bzr in this case?

I was also bitten by this "feature" of Git.  Until I decided to put a  
bare repo in between and push my commits there.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory
