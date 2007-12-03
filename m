From: "Jacob Kroon" <jacob.kroon@gmail.com>
Subject: Pack several linear commits into one
Date: Mon, 3 Dec 2007 10:06:11 +0100
Message-ID: <c0d4c9e90712030106u40b871ecjd5f7b8d078c8be36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 10:06:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz7G6-0001XL-50
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 10:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbXLCJGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 04:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbXLCJGO
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 04:06:14 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:39773 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbXLCJGM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 04:06:12 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4987623wah
        for <git@vger.kernel.org>; Mon, 03 Dec 2007 01:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=r0+BLq++AJw3RIxdZ9B2YjUQ5300CZpbP38fw4R9h/8=;
        b=AguIE9PO3bbGXl0tcyOeqZv5xfe2DWN0qlqW20qMtOk9w5QpmfXfwGz+Ji2fvMnyQ+CpgXzq5L04zijWzxezmpTFdztodtaeBrM1Qu9ZATVhuZAS6f2BvKHfNZLBBP7wuQbQthcE865nHij/xpkWepQEOU2NZcWiWqtPnntqqMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=a2sc6k8LLdnlFkVD/SL/N3cX2bqAxp4rT7/nPVlIf2o7f1HGqtjzEdqP9qU22u90kY8y/izzuFkxPeF2e0SYGjiDPcNMfIG9Q9GN5SLbgAIz5sesq732Zmd1BSVKZ/BynY8aW35LAww1v2VJYfgpz/Cq+V8W780nR0V+WD+rGg8=
Received: by 10.142.44.11 with SMTP id r11mr177191wfr.1196672771970;
        Mon, 03 Dec 2007 01:06:11 -0800 (PST)
Received: by 10.142.135.1 with HTTP; Mon, 3 Dec 2007 01:06:11 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66890>

Hi,

Is there a tool for repacking several linear commits into one single ?

Please CC me since I'm not a subscriber to the list.

Best Regards
Jacob Kroon
