From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/2] gitk Hungarian translation updates
Date: Mon, 14 Dec 2009 14:12:23 +0100
Message-ID: <cover.1260796071.git.vmiklos@frugalware.org>
References: <20091214123057.GL25474@genesis.frugalware.org>
Cc: Laszlo Papp <djszapi2@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 14:12:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKAjF-0005Ll-9T
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 14:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648AbZLNNM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 08:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752635AbZLNNMZ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 08:12:25 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:49314 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbZLNNMY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 08:12:24 -0500
Received: from vmobile.example.net (dsl5401C437.pool.t-online.hu [84.1.196.55])
	by yugo.frugalware.org (Postfix) with ESMTPA id BCB071CBCF5;
	Mon, 14 Dec 2009 14:12:22 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 219DE182035; Mon, 14 Dec 2009 14:12:26 +0100 (CET)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091214123057.GL25474@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135209>

Hi,

These two patches are on top of Laszlo's initial translation.

The first patch is the patch from Junio, the best would be to squash it
in Laszlo's one.

The second patch updates the translation as there were numerous
untranslated and fuzzy strings.

Miklos Vajna (2):
  Fix up gitk-git Hungarian translation
  Update gitk-git Hungarian translation

 gitk-git/po/hu.po |  772 +++++++++++++++++++++++++++++++----------------------
 1 files changed, 458 insertions(+), 314 deletions(-)
