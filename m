From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: git on ancient compilers.
Date: Fri, 9 Nov 2007 18:19:07 -0500
Message-ID: <9e4733910711091519r75692418hec2fbd7ccea5771b@mail.gmail.com>
References: <9e4733910711091514k55473201jf29434961f01e46c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 00:19:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqd8L-00080U-CG
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 00:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756385AbXKIXTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 18:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756298AbXKIXTM
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 18:19:12 -0500
Received: from nz-out-0506.google.com ([64.233.162.235]:45776 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370AbXKIXTI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 18:19:08 -0500
Received: by nz-out-0506.google.com with SMTP id s18so636360nze
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 15:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=M4HjV6i2Ik//wkJVx+V9I6pv0BGkF4ZWt+Ywfnea5L8=;
        b=MyaKZjyg2ST5BReG2JJ/+PHuzvvL8zawR3WzH1yOWGa1MsZtLvOb7BWjnhWRjwb+HVXZn89kT6ab0BfildkAIPGB5i6M4D2eegQVJRGKFCb/jV0ETjs5t4wI1V878dTYH+/LMXkZ1esffxcZ+iV98G4dJGgkfgZ6Gd3dH5zK8DI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TAhsA+QLkj5EyIvzuqfTyJRW10Ixc+ddUqnsugSZtV4UQFHPo9vqcZSZTQTOdVEGi6b+CltlwplFjxqHV7h5X0RBO/Vm7PaNESfz2sj6O13kVASvF+45MXj9YeAXXVRPW2RNg0FCPcLHe03yoEatg/NzJaYVWX2JmeHqzWSjc/c=
Received: by 10.114.181.1 with SMTP id d1mr96721waf.1194650347123;
        Fri, 09 Nov 2007 15:19:07 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Fri, 9 Nov 2007 15:19:07 -0800 (PST)
In-Reply-To: <9e4733910711091514k55473201jf29434961f01e46c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64273>

jonsmirl@terra:~$ ld --version
GNU ld (GNU Binutils for Ubuntu) 2.18

-- 
Jon Smirl
jonsmirl@gmail.com
