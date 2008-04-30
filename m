From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Havoc Pennington on git and easygit
Date: Wed, 30 Apr 2008 19:56:40 -0400
Message-ID: <32541b130804301656s3989bab7xcfaa4efd331ca63c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 01 01:57:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrMB4-0000Mu-TV
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 01:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760519AbYD3X4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 19:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757156AbYD3X4p
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 19:56:45 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:34882 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207AbYD3X4p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 19:56:45 -0400
Received: by fk-out-0910.google.com with SMTP id 18so547058fkq.5
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 16:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=w4c62PiWiKxVTSy7YgzPnYHgThefeEDJSKHcTmHezkg=;
        b=YIH4wA7iwE1PtWZDWlUo8zN6yZ2L1uDoX5gpIkIhVGkh5F/baQ+iBWZLD6XCX5J8RU1rZG532D1cF+ou5XPh5HEPastkwdy6AJtbmRQUm+wboTTStGjWAPl/t/bgebdh7VyBAFQdU7QWwxs9wm39AlobTvcwuz4TnXgyUobPVsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kTzF06yfwWzDbG88cnUF32T90R9vmnS54AukMapMyc/w/igEBVD2YuIhWslMlTiiWlFI1H93V9YQzQkLhryQQQkpjF+ewoBHh2vPn06PZensCqm4e5Va/hUtrjKMKFABCKJbmbVJqWfePogsktm00b1SCVqDXTQpanX5b1RAlpk=
Received: by 10.82.161.19 with SMTP id j19mr194828bue.48.1209599800666;
        Wed, 30 Apr 2008 16:56:40 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 30 Apr 2008 16:56:40 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80880>

For those that don't follow Havoc's postings, this one about git is
quite well thought out:

http://log.ometer.com/2008-04.html#29

His comments very much parallel my own learning experience and others
here, except that he's more stubborn about learning git's internals
than I was.

Have fun,

Avery
