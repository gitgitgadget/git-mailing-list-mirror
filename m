From: "Simon Chiang" <simon.a.chiang@gmail.com>
Subject: Re: Do moves add to repository size?
Date: Wed, 31 Dec 2008 08:53:45 -0700
Message-ID: <85fafb0c0812310753p6c112bd3q37ac772b5b82c05d@mail.gmail.com>
References: <85fafb0c0812310111s552247em5f0ca57b737aedc3@mail.gmail.com>
	 <81b0412b0812310717w341f05b5qeb058ff1c2db19d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 16:58:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LI3SL-00045S-66
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 16:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384AbYLaPxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 10:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755144AbYLaPxr
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 10:53:47 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:4667 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923AbYLaPxr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 10:53:47 -0500
Received: by wf-out-1314.google.com with SMTP id 27so5846334wfd.4
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 07:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yanwD5UdVzC4vCcTsY93JqQ7Y15KKv+eRUixMJWvFSA=;
        b=Fu+ar+ZtVDs9x9YJIU29HimkqZ8LD6XHxYpZcbt1ssHD2o8Yz2H/Tgl7RsNpr5PY+v
         qiIHshHoL+Nec1BNWIFzNz++dGElvLjT8coAZiEa25NqORIHPj3LUDHOoVIXNFqtg6HF
         UAYXNjppqJt8Vzx0d4jER0AmpHZX0etzQifiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tRWNegRc9T/Ttrh4Huix26mnPmrw78xUwfqHypU/TQMagkopgHurLV/1MNw3BydJxX
         Q3thFjRpldYQv44PUyUmgWz5j7QdiHfSDw2HhGgkmzZKdri6jC5OR8bYIUScVr5sIoNM
         SIJRlJ349ro80sHjEV4WPSmkzkHn9U2IGfR8Q=
Received: by 10.114.125.15 with SMTP id x15mr10582787wac.42.1230738825890;
        Wed, 31 Dec 2008 07:53:45 -0800 (PST)
Received: by 10.114.202.11 with HTTP; Wed, 31 Dec 2008 07:53:45 -0800 (PST)
In-Reply-To: <81b0412b0812310717w341f05b5qeb058ff1c2db19d2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104276>

Great thanks!  I suspected that was the case.
