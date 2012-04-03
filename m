From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [GSOC] Contributing to git.
Date: Tue, 3 Apr 2012 09:39:36 +0800
Message-ID: <CAEY4ZpM3ir3Vye=QsUonpv=soO2qVsm2ZJFEyhigt8E_1sgZ_A@mail.gmail.com>
References: <CAH-tXsB39OpbmVcD3Fd+tq8UcBsyCf6JBZ-rSyf1VwrQPKLiFQ@mail.gmail.com>
	<201203301305.23567.jnareb@gmail.com>
	<CAH-tXsAMJXNs7fM=9msiZT+F_s_06o526kPXLLcQzABBePHxwQ@mail.gmail.com>
	<201203310137.59657.jnareb@gmail.com>
	<CAEY4ZpNek5-8s6hG8qUos9TfNEn83Hf4KCyCcreY3MM5P9qAkw@mail.gmail.com>
	<CAH-tXsA0wdtryrQ0d+31nLp+JRBnL0OMhpbOHUjMC=6N26GMDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: jaseem abid <jaseemabid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 03:39:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEsil-0001A5-JR
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 03:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712Ab2DCBji convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Apr 2012 21:39:38 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56181 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab2DCBjh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Apr 2012 21:39:37 -0400
Received: by vbbff1 with SMTP id ff1so2078826vbb.19
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 18:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=kMhgdDcwbPUVNW3GgYxjpGWDz9Jraf+awixxYwhSfLo=;
        b=VY/ggsYPuj6nH+opnU+Bssk2qeRbJmokL0BM0al/J3R4M6vlKcuRdpcf5a/auKpBL7
         Gv5fv8H6yRWctKnwcz31+J22Mi+EEnQpp0Gp9TaVQqqetginsvHOIPJwMB9CkzbVAd9R
         we1oY+6uZuxrcBlSqVRyBILsAFiTfIqiS/lC9RelRVWg+UgqNztvcr2A7D9Ic/Hy1ki/
         oMw21DsEIMDfEhOzCB3g22/q7gRrTziSWypDhPa/RY6A/G7HqJozQM8IVYw8V5cXst26
         oxpdSRM9K6rObe7pT/2e8EuMPMatbsAKDiZJQ4Uvpq16D5xUYIR772jXeeRH3FMg9btt
         7UFg==
Received: by 10.52.29.145 with SMTP id k17mr4606258vdh.124.1333417176822; Mon,
 02 Apr 2012 18:39:36 -0700 (PDT)
Received: by 10.220.171.193 with HTTP; Mon, 2 Apr 2012 18:39:36 -0700 (PDT)
In-Reply-To: <CAH-tXsA0wdtryrQ0d+31nLp+JRBnL0OMhpbOHUjMC=6N26GMDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194583>

On Tue, Apr 3, 2012 at 12:26 AM, jaseem abid <jaseemabid@gmail.com> wro=
te:
> It feels like too much for this project. Do we need all the features
> from these projects? As far as I can understand, you need phantom.js
> to be installed in your local development machine, which is a new
> dependency. =A0I have an instruction from the community not to add ne=
w
> dependencies.

Ah that is true. I forgot about the overhead of getting phantomjs insta=
lled.

nazri
