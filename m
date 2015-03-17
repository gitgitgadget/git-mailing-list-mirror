From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: FW: Time Date on file
Date: Tue, 17 Mar 2015 19:15:45 +0100
Message-ID: <1426616145.6581.3.camel@kaarsemaker.net>
References: <54e23b899e85c_57bb3fbf49e312bc81524@github-fe127-cp1-prd.iad.github.net.mail>
	 <discussions/7a29a8f6b60c11e49e9dc65939c25d64/comments/1711928@github.com>
	 <000f01d060d6$79c2c5e0$6d4851a0$@steltec.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: networkadmin@steltec.ca
X-From: git-owner@vger.kernel.org Tue Mar 17 19:15:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXw1x-0008JL-QC
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 19:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbbCQSPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 14:15:49 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35132 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbbCQSPs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 14:15:48 -0400
Received: by wibdy8 with SMTP id dy8so70181223wib.0
        for <git@vger.kernel.org>; Tue, 17 Mar 2015 11:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=5yWOOccHig+rgelC/TSpMnJ96/Iwj51OQ46tydPqZIk=;
        b=HcD4gzO5M0zPCy4UAMPtoMfqU1Js3/exV1R0R9MQMmv3L7Ea6TFp/MnV/J3Ad1tsnR
         7W5oYJ0GoQgTEDTey4ZQ5L0+hsS55oNBXSHN+AzPWHzUMn3bsTLiHg72pTo08XcXU7/O
         Ib7x3lDgCYVOx/UBbHgCG9LoNiNE3B/Qr6OXsTMYHlPXTwSKYxejmRELTwVzmcWuJYPa
         NdPcfkqR98fz6jnoLExluFPiL5TQJC+dpj0s2gNbeiLaZ3Cvw1rwP4H0AXB5EN5aUgDz
         l/vmK7PWqn67WzQk2kJr2UslWjl5mrFjjpRhv71PHyOuVIW8OR8iWvOUbq9Bo386NcA4
         GURw==
X-Gm-Message-State: ALoCoQmbsEpw7yTf0QoPYcM3HNshnt4Uan96M7XwvwDFyoQEu9LTROezWlEe/L22uiHLgIUoV7hn
X-Received: by 10.180.207.237 with SMTP id lz13mr132952251wic.15.1426616147742;
        Tue, 17 Mar 2015 11:15:47 -0700 (PDT)
Received: from spirit.home.kaarsemaker.net (82-171-80-33.ip.telfort.nl. [82.171.80.33])
        by mx.google.com with ESMTPSA id w4sm3699055wib.19.2015.03.17.11.15.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2015 11:15:46 -0700 (PDT)
In-Reply-To: <000f01d060d6$79c2c5e0$6d4851a0$@steltec.ca>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265649>

On di, 2015-03-17 at 13:19 -0400, Patrice Monette wrote:
> 
> I did not find any config, but is there one configuration somewhere to
> preserve the real date creation by author somewhere?

No, there is no such configuration as git does not track timestamps of
files.
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
