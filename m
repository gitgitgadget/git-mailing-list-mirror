From: Jiang Xin <worldhello.net@gmail.com>
Subject: A huge update of git.pot is coming with 825 new, 24 removed messages
Date: Sat, 15 Sep 2012 10:46:11 +0800
Message-ID: <CANYiYbF7k5gJjWPpQS1ZqagMycHBMmHSJbLPOAFGgj4W-neL8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
	Riku <lu.riku@gmail.com>, Zhuang Ya <zhuangya@me.com>,
	Lian Cheng <rhythm.mail@gmail.com>,
	Yichao Yu <yyc1992@gmail.com>,
	ws3389 <willsmith3389@gmail.com>, Thynson <lanxingcan@gmail.com>,
	=?UTF-8?B?RGF2aWQgSHJiw6HEjQ==?= <david@hr
X-From: git-owner@vger.kernel.org Sat Sep 15 04:46:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCiOk-00010n-AR
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 04:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755709Ab2IOCqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 22:46:14 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50421 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128Ab2IOCqM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 22:46:12 -0400
Received: by iahk25 with SMTP id k25so3990212iah.19
        for <git@vger.kernel.org>; Fri, 14 Sep 2012 19:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=SCalTiAfQqCPvoZfO1LQO5t80mlM1K51JdB8vS//AJI=;
        b=proIpL3lZvm0uWLS0GEknEeLcxrRMqH6nE0JhJgYBbKLkmObksPvUUkTpxDARUNgj0
         3NS9JF3+ZbLFdDwPtvSQ2MiDER+6LbNx8zVq3ICHYW0dl0sLlVl5M6ZzQJ15CcHk6N5i
         YiqKag5wCNjCMiDUkW8N5RlBWvfkjjpewQoG0mR74oN4aui2wCsx4GI2fJ4wrnCFLNFB
         7tWVAg9L4D4/dVR5ePadtdihd5ZOWKSpqP/tpVZPjTxMmYovzn7sz++1R1Rsu4mbW3ui
         Oe0/hd3MTVh+rrviIBCUU5doKVmaDiykMu0FztQ2AEhF0CZL9lySF619WIHORIH1txvG
         /0TA==
Received: by 10.50.207.106 with SMTP id lv10mr353240igc.0.1347677171762; Fri,
 14 Sep 2012 19:46:11 -0700 (PDT)
Received: by 10.50.42.230 with HTTP; Fri, 14 Sep 2012 19:46:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205545>

Dear l10n team members,

New "git.pot" is generated from v1.7.12-437-g1084f in the master branch.

    l10n: Update git.pot (825 new, 24 removed messages)

    Generate po/git.pot from v1.7.12-437-g1084f with these i18n update(s):

     * i18n: mark more index-pack strings for translation
     * i18n: write-tree: mark parseopt strings for translation
     * i18n: verify-tag: mark parseopt strings for translation
     * i18n: verify-pack: mark parseopt strings for translation
     * i18n: update-server-info: mark parseopt strings for translation
     * i18n: update-ref: mark parseopt strings for translation
     * i18n: update-index: mark parseopt strings for translation
     * i18n: tag: mark parseopt strings for translation
     * i18n: symbolic-ref: mark parseopt strings for translation
     * i18n: show-ref: mark parseopt strings for translation
     * i18n: show-branch: mark parseopt strings for translation
     * i18n: shortlog: mark parseopt strings for translation
     * i18n: rm: mark parseopt strings for translation
     * i18n: revert, cherry-pick: mark parseopt strings for translation
     * i18n: rev-parse: mark parseopt strings for translation
     * i18n: reset: mark parseopt strings for translation
     * i18n: rerere: mark parseopt strings for translation
     * i18n: status: mark parseopt strings for translation
     * i18n: replace: mark parseopt strings for translation
     * i18n: remote: mark parseopt strings for translation
     * i18n: read-tree: mark parseopt strings for translation
     * i18n: push: mark parseopt strings for translation
     * i18n: prune: mark parseopt strings for translation
     * i18n: prune-packed: mark parseopt strings for translation
     * i18n: pack-refs: mark parseopt strings for translation
     * i18n: pack-objects: mark parseopt strings for translation
     * i18n: notes: mark parseopt strings for translation
     * i18n: name-rev: mark parseopt strings for translation
     * i18n: mv: mark parseopt strings for translation
     * i18n: mktree: mark parseopt strings for translation
     * i18n: merge: mark parseopt strings for translation
     * i18n: merge-file: mark parseopt strings for translation
     * i18n: merge-base: mark parseopt strings for translation
     * i18n: ls-tree: mark parseopt strings for translation
     * i18n: ls-files: mark parseopt strings for translation
     * i18n: log: mark parseopt strings for translation
     * i18n: init-db: mark parseopt strings for translation
     * i18n: help: mark parseopt strings for translation
     * i18n: hash-object: mark parseopt strings for translation
     * i18n: grep: mark parseopt strings for translation
     * i18n: gc: mark parseopt strings for translation
     * i18n: fsck: mark parseopt strings for translation
     * i18n: format-patch: mark parseopt strings for translation
     * i18n: for-each-ref: mark parseopt strings for translation
     * i18n: fmt-merge-msg: mark parseopt strings for translation
     * i18n: fetch: mark parseopt strings for translation
     * i18n: fast-export: mark parseopt strings for translation
     * i18n: describe: mark parseopt strings for translation
     * i18n: config: mark parseopt strings for translation
     * i18n: count-objects: mark parseopt strings for translation
     * i18n: commit: mark parseopt strings for translation
     * i18n: column: mark parseopt strings for translation
     * i18n: clone: mark parseopt strings for translation
     * i18n: clean: mark parseopt strings for translation
     * i18n: cherry: mark parseopt strings for translation
     * i18n: checkout: mark parseopt strings for translation
     * i18n: checkout-index: mark parseopt strings for translation
     * i18n: check-attr: mark parseopt strings for translation
     * i18n: cat-file: mark parseopt strings for translation
     * i18n: branch: mark parseopt strings for translation
     * i18n: blame: mark parseopt strings for translation
     * i18n: add: mark parseopt strings for translation
     * i18n: bisect--helper: mark parseopt strings for translation
     * i18n: archive: mark parseopt strings for translation
     * i18n: mark "style" in OPT_COLUMN() for translation

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

It's time for a new round of translation.

 * Fetch new commits from git://github.com/git-l10n/git-po
 * Update your "XX.po" according to the new "git.pot" file.
 * Start your translation and review your commits inside your l10n team.
 * Send a pull request to git-l10n/git-po on GitHub.

-- 
Jiang Xin
