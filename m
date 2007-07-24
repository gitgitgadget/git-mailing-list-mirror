From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: question on alternates
Date: Tue, 24 Jul 2007 13:00:54 +0300
Message-ID: <20070724100053.GA18701@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 12:01:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDHCo-0004Ap-S4
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 12:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933585AbXGXKBF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 06:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765995AbXGXKBE
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 06:01:04 -0400
Received: from hu-out-0506.google.com ([72.14.214.234]:22449 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932853AbXGXKBB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 06:01:01 -0400
Received: by hu-out-0506.google.com with SMTP id 19so1506435hue
        for <git@vger.kernel.org>; Tue, 24 Jul 2007 03:00:59 -0700 (PDT)
Received: by 10.67.22.14 with SMTP id z14mr515503ugi.1185271259530;
        Tue, 24 Jul 2007 03:00:59 -0700 (PDT)
Received: from ?127.0.0.1? ( [217.132.35.163])
        by mx.google.com with ESMTPS id k2sm160511ugf.2007.07.24.03.00.58
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2007 03:00:59 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53550>

Is it possible to add an alternate to .git/objects/info/alternates
to an existig repository, after the fact?
If I do, is there a way to find and remove objects that
already exist in the alternate?

Thanks,

-- 
MST
