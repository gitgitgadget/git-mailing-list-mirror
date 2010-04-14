From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4 0/3] git-diff --word-diff/gitk --color-words
Date: Wed, 14 Apr 2010 17:59:05 +0200
Message-ID: <cover.1271260308.git.trast@student.ethz.ch>
References: <7v8w8sljjr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>, Miles Bader <miles@gnu.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 14 17:59:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O24zv-0008Qa-0B
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 17:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756108Ab0DNP7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 11:59:17 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:16484 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755653Ab0DNP7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 11:59:16 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 14 Apr
 2010 17:59:15 +0200
Received: from localhost.localdomain (129.132.247.68) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.247.2; Wed, 14 Apr
 2010 17:59:08 +0200
X-Mailer: git-send-email 1.7.1.rc1.265.g77471
In-Reply-To: <7v8w8sljjr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144886>

This merely addresses Junio's comments on 1/3 of the last round, since
I haven't heard anything about the gitk patches.


Thomas Rast (3):
  diff: add --word-diff option that generalizes --color-words
  gitk: do not parse "  >" context as submodule change
  gitk: add the equivalent of diff --color-words
