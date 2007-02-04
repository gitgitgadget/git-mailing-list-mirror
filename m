From: "Marco Costalba" <mcostalba@gmail.com>
Subject: 'git config' vs 'git repo-config'
Date: Sun, 4 Feb 2007 10:38:36 +0100
Message-ID: <e5bfff550702040138r6580c36agf86e8f8191a40021@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 10:38:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDdpX-0008TU-Oe
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 10:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200AbXBDJih (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 04:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbXBDJih
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 04:38:37 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:62943 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbXBDJih (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 04:38:37 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1328589nze
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 01:38:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=S+ETRudl5YUHfkauVWAmQDkwFV3FCkLCpKN/satkby1ZTnLQ5PbPNpVIJhJ0wPzZATwFuMJWAsCy5Se0JWFFQMSfSfYKpQ0zY4bo3M/zjqF4FNE3ONb1xvXZ/0Q/Hi/mfBu/HH85NmyXEyDYMVyjv100qk7Y+jpLS53V6Iir2jw=
Received: by 10.114.175.16 with SMTP id x16mr505768wae.1170581916210;
        Sun, 04 Feb 2007 01:38:36 -0800 (PST)
Received: by 10.114.61.6 with HTTP; Sun, 4 Feb 2007 01:38:36 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38673>

Hi Junio,

  I've seen that 'git repo-config' has been renamed 'git config', but
old name is still available for back compatibility.

Do you plan to remove it in a near future?

Probably you already now why I'm asking this ;-)

Thanks
Marco
