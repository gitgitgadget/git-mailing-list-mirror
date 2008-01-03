From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: [RFH] On a script for submodules
Date: Thu, 3 Jan 2008 15:07:04 +0600
Message-ID: <7bfdc29a0801030107t54ca45dbq167666b337f59a01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 03 10:07:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAM37-00065x-PE
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 10:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbYACJHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 04:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752600AbYACJHJ
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 04:07:09 -0500
Received: from hu-out-0506.google.com ([72.14.214.225]:20711 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559AbYACJHH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 04:07:07 -0500
Received: by hu-out-0506.google.com with SMTP id 19so694139hue.21
        for <git@vger.kernel.org>; Thu, 03 Jan 2008 01:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=EU6WP57PxVxAAWjJ5K1O4KIj6bOJE6q0ncl35L0M1ns=;
        b=BZuGhDCm9Jzz6/uupqBJkWz0EW6rnJ0IqysSGKasYw4Z3jDJSjGpzCeru385WVToRnwS+dYYTrrTBpevuEHQxi7GpTfltJWxc6aZT3DO4qxhTVYZpDCb67TiP+fNkw3LpU0tpOjqGG4va5I5LUGC49Gj2B6YJ2CRuKr7pU+QDWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BP32jrDjI2jc31yKI4Ia/lbfF5gaKfDTPBteJk1t3d8aHR/1NZXyF+D48322wrsjpACFpKRkrPp1mOGVffce/3Ictq/aUi7jsCAwqkR2UBnSldsvcK1/axxtRNnjDw2jj5zMAskDo4LtUQjlN/RRWsCMmly2+plrQLzwHQnVd80=
Received: by 10.78.136.9 with SMTP id j9mr17734593hud.70.1199351224135;
        Thu, 03 Jan 2008 01:07:04 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Thu, 3 Jan 2008 01:07:04 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69516>

Hi All,

I started writing a script intended for modular (Git modules)
projects. The script can be found at
http://repo.or.cz/w/git-modules-bs.git. This is a very rudimentary
version and I intend to make it more useful for developers who work
with multiple modules. I would also like to mention that I am not an
expert shell scripter thus probably have made several mistakes in the
script; I would really appreciate if someone would take their time to
suggest me improvements. I would also like to get some feedbacks as
what else could be added here. A brief description can be found in the
following posting.

http://imyousuf-tech.blogs.smartitengineering.com/2008/01/propagating-git-commands-to-its.html

Thank you,

-- 
Imran M Yousuf
