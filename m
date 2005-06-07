From: "McMullan, Jason" <jason.mcmullan@timesys.com>
Subject: Re: [PATCH] Add git-help-script
Date: Tue, 07 Jun 2005 10:25:41 -0400
Message-ID: <1118154342.8970.57.camel@jmcmullan.timesys>
References: <20050607141944.GA14915@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="=-wM6/QSN/bsw2LDmOPDA3";
	micalg=pgp-sha1;
	protocol="application/pgp-signature"
X-From: git-owner@vger.kernel.org Tue Jun 07 16:24:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfeyN-00081Q-SN
	for gcvg-git@gmane.org; Tue, 07 Jun 2005 16:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVFGO0L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Jun 2005 10:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVFGO0L
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jun 2005 10:26:11 -0400
Received: from mail.timesys.com ([65.117.135.102]:54288 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261877AbVFGOZo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2005 10:25:44 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Received: from jmcmullan by owa.timesys.com; 07 Jun 2005 10:25:42 -0400
In-Reply-To: <20050607141944.GA14915@jmcmullan.timesys>
X-Mailer: Evolution 2.0.4-3mdk 
Content-Class: urn:content-classes:message
X-Mailer: Evolution 2.0.4-3mdk 
Date: Tue, 7 Jun 2005 10:18:40 -0400
Message-ID: <1118154342.8970.57.camel@jmcmullan.timesys>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Add git-help-script
thread-index: AcVra81uLc8RAxStTYSE5le1Pe+Usw==
To: "Linus Torvalds" <torvalds@osdl.org>,
	"GIT Mailling list" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-wM6/QSN/bsw2LDmOPDA3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

NOTE: This patch requires '[PATCH] Add missing Documention/*'


Here's the example output of 'git-help-script', which is called
when the user doesn't supply any options to the 'git' script wrapper,
or -h, or --help


$ git=20
Commands:

    git                 the stupid content tracker
    git apply-patch     Sample script to apply the diffs from git-diff-*
    git commit          Commit working directory

    git deltafy         Convery repository into delta format
    git fetch           Fetch an object from a remote repository
    git help            Short help of all the git commands and scripts
    git log            =20
    git merge-one-file  The standard helper program to use with
"git-merge-cache"
    git prune           Prunes all unreachable objects from the object
                        database
    git pull            Script used by Linus to pull and merge a
                        remote repository
    git resolve         Script used to merge two trees
    git-shortlog       =20
    git status         =20
    git tag             An example script to create a tag object
                        signed with GPG
    git-whatchanged     Find out what changed
    git-apply           Apply a patch against the current index
cache/working
                        directory
    git-cat-file        Provide content or type information for
repository
                        objects
    git-check-files     Verify a list of files are up-to-date
    git-checkout-cache  Copy files from the cache to the working
                        directory
    git-commit-tree     Creates a new commit object
    git-convert-cache   Converts old-style GIT repository
    git-diff-cache      Compares content and mode of blobs between
                        the cache and repository
    git-diff-files      Compares files in the working tree and the
                        cache
    git-diff-helper     Generates patch format output for git-diff-*
    git-diff-tree       Compares the content and mode of blobs found
                        via two tree objects
    git-export          Exports each commit and a diff against each
                        of its parents
    git-fsck-cache      Verifies the connectivity and validity of
                        the objects in the database
    git-get-tar-commit-idShow the commit ID embedded in a git-tar-tree
                        file.
    git-http-pull       Downloads a remote GIT repository via HTTP
    git-init-db         Creates an empty git object database
    git-local-pull      Duplicates another GIT repository on a local
                        system
    git-ls-files        Information about files in the cache/working
                        directory
    git-ls-tree         Lists the contents of a tree object.
    git-merge-base      Finds as good a common ancestor as possible
                        for a merge
    git-merge-cache     Runs a merge for files needing merging
    git-mkdelta         Creates a delta object
    git-mktag           Creates a tag object
    git-read-tree       Reads tree information into the directory
                        cache
    git-rev-list        Lists commit objects in reverse chronological
                        order
    git-rev-tree        Provides the revision tree for one or more
                        commits
    git-ssh-pull        Pulls from a remote repository over ssh
connection
    git-ssh-push        Pushes to a remote repository over ssh
connection
    git-stripspace      Strip space from stdin
    git-tar-tree        Creates a tar archive of the files in the
                        named tree
    git-unpack-file     Creates a temporary file with a blob's contents
    git-update-cache    Modifies the index or directory cache
    git-write-blob      Creates a blob from a file
    git-write-tree      Creates a tree from the current cache

--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-wM6/QSN/bsw2LDmOPDA3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCpa5l8/0vJ5szK6kRAp2hAJ94zsrtDCFOYcLMIUFHy/o/MzF7aACgxZGu
PIHa5D1ZdIIyU6iA447/Kzk=
=qxby
-----END PGP SIGNATURE-----

--=-wM6/QSN/bsw2LDmOPDA3--
