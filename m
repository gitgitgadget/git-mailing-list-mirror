From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster-Mmb7MZpHnFY@public.gmane.org>
Subject: (local ?) BOINC repo broken again -or- how to act on
 the CR/LF changes made upstream
Date: Fri, 12 Sep 2014 20:09:26 +0200
Message-ID: <541336D6.3050803@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030408060702040307040300"
Cc: "boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org" <boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>
To: "git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
X-From: boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org Fri Sep 12 20:09:36 2014
Return-path: <boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>
Envelope-to: gcdbd-boinc_dev-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from mailapps1.ssl.berkeley.edu ([128.32.13.237])
	by plane.gmane.org with smtp (Exim 4.69)
	(envelope-from <boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>)
	id 1XSVHr-0007E8-Lz
	for gcdbd-boinc_dev-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Fri, 12 Sep 2014 20:09:36 +0200
Received: from mailapps1.ssl.berkeley.edu (localhost [127.0.0.1])
	by mailapps1.ssl.berkeley.edu (Postfix) with ESMTP id 25B752FEA47;
	Fri, 12 Sep 2014 11:09:32 -0700 (PDT)
X-Original-To: boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org
Delivered-To: boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org
Received: from mail2.ssl.berkeley.edu (mail2.ssl.berkeley.edu [128.32.13.252])
	by mailapps1.ssl.berkeley.edu (Postfix) with ESMTP id B13872FEA40
	for <boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org>;
	Fri, 12 Sep 2014 11:09:30 -0700 (PDT)
Received: from mailwall2.ssl.berkeley.edu (mailwall2.ssl.berkeley.edu
	[128.32.147.8])
	by mail2.ssl.berkeley.edu (8.13.8/8.13.8) with ESMTP id s8CI9UB9030931
	for <boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>; Fri, 12 Sep 2014 11:09:30 -0700
X-ASG-Debug-ID: 1410545369-04b397146129ca90001-LQ66t1
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21]) by
	mailwall2.ssl.berkeley.edu with ESMTP id Y21EqzxR25WVRcaZ for
	<boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>; Fri, 12 Sep 2014 11:09:29 -0700 (PDT)
X-Barracuda-Envelope-From: toralf.foerster-Mmb7MZpHnFY@public.gmane.org
X-Barracuda-Apparent-Source-IP: 212.227.17.21
Received: from [192.168.178.21] ([78.54.159.21]) by mail.gmx.com (mrgmx102)
	with ESMTPSA (Nemesis) id 0MQ7sF-1XNGDc3Lmt-005KQZ;
	Fri, 12 Sep 2014 20:09:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:31.0) Gecko/20100101 Thunderbird/31.1.1
X-ASG-Orig-Subj: (local ?) BOINC repo broken again -or- how to act on the
	CR/LF changes made upstream
X-Provags-ID: V03:K0:p6XKzp/pSFMwkJnquSamtWw5ChOzwah+mxLrPQvZaY3jY7SIv3w
	kudJKwxy23bBrHl3irOnNIcLcVZMiFVaTmF/VBW6Og47t4SWlyU5q5XIeEWnPsDp6DdjFXm
	78TCnv7U9o8tFTU5Iq4ZKlgyMnbrvtg3SC2y+diUmZcLnYvu+nFGr4ublMqoEdzCIs3JTA0
	ohMHIih5wud7yYZ1ZWK5Q==
X-UI-Out-Filterresults: notjunk:1;
X-Barracuda-Connect: mout.gmx.net[212.227.17.21]
X-Barracuda-Start-Time: 1410545369
X-Barracuda-URL: http://mailwall2.ssl.berkeley.edu:8000/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at ssl.berkeley.edu
X-Barracuda-Spam-Score-Disabled: per user
X-BeenThere: boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: BOINC development <boinc_dev.ssl.berkeley.edu>
List-Unsubscribe: <http://lists.ssl.berkeley.edu/mailman/options/boinc_dev>,
	<mailto:boinc_dev-request-C9EgComYM8RUAgJt6FLh2g@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ssl.berkeley.edu/pipermail/boinc_dev/>
List-Post: <mailto:boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>
List-Help: <mailto:boinc_dev-request-C9EgComYM8RUAgJt6FLh2g@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ssl.berkeley.edu/mailman/listinfo/boinc_dev>,
	<mailto:boinc_dev-request-C9EgComYM8RUAgJt6FLh2g@public.gmane.org?subject=subscribe>
Errors-To: boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org
Sender: "boinc_dev" <boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256935>

This is a multi-part message in MIME format.
--------------030408060702040307040300
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Today I run again into the CR/LF pain when I pulled from BOINC upstream a=
nd me wonders how I can "repair" the repository using git-2.1.0 at a 32bi=
t Linux without cloning the full repository again (as I did it in the pas=
t). FWIW I did not changed anything locally, I just do pull regularly fro=
m upstreem to create a tar-ball of the current version for my own purpose=
:


tfoerste@n22 ~/devel/trinity $ cd ~/devel/boinc-v2; git pull
remote: Counting objects: 104, done.
remote: Compressing objects: 100% (52/52), done.
remote: Total 52 (delta 42), reused 0 (delta 0)
Unpacking objects: 100% (52/52), done.
From git://boinc.berkeley.edu/boinc-v2
   ce97e85..d2e5582  master     -> origin/master
   194f1dc..4a696b4  client_release/7/7.4 -> origin/client_release/7/7.4
Updating ce97e85..d2e5582
error: Your local changes to the following files would be overwritten by =
merge:
        html/languages/translations/hu.po
        html/languages/translations/nl.po
        locale/bg/BOINC-Web.po
        locale/da/BOINC-Web.po
        locale/el/BOINC-Web.po
        locale/fr/BOINC-Web.po
        locale/hr/BOINC-Web.po
        locale/hu/BOINC-Project-Generic.po
        locale/hu/BOINC-Web.po
        locale/it_IT/BOINC-Project-Generic.po
        locale/lv/BOINC-Web.po
        locale/nl/BOINC-Project-Generic.po
        locale/nl/BOINC-Web.po
        locale/pl/BOINC-Web.po
        locale/pt_BR/BOINC-Web.po
        locale/ro/BOINC-Web.po
        locale/sk/BOINC-Web.po
        locale/zh_TW/BOINC-Web.po
Please, commit your changes or stash them before you can merge.
Aborting

tfoerste@n22 ~/devel/boinc-v2 $ git diff

tfoerste@n22 ~/devel/boinc-v2 $ git status
On branch master
Your branch is behind 'origin/master' by 7 commits, and can be fast-forwa=
rded.
  (use "git pull" to update your local branch)
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working director=
y)

        modified:   html/languages/translations/hu.po
        modified:   html/languages/translations/nl.po
        modified:   locale/bg/BOINC-Web.po
        modified:   locale/da/BOINC-Web.po
        modified:   locale/el/BOINC-Web.po
        modified:   locale/fr/BOINC-Web.po
        modified:   locale/hr/BOINC-Web.po
        modified:   locale/hu/BOINC-Project-Generic.po
        modified:   locale/hu/BOINC-Web.po
        modified:   locale/it_IT/BOINC-Project-Generic.po
        modified:   locale/lv/BOINC-Web.po
        modified:   locale/nl/BOINC-Project-Generic.po
        modified:   locale/nl/BOINC-Web.po
        modified:   locale/pl/BOINC-Web.po
        modified:   locale/pt_BR/BOINC-Web.po
        modified:   locale/ro/BOINC-Web.po
        modified:   locale/sk/BOINC-Web.po
        modified:   locale/zh_TW/BOINC-Web.po

no changes added to commit (use "git add" and/or "git commit -a")


tfoerste@n22 ~/devel/boinc-v2 $ git branch=20
* master

tfoerste@n22 ~/devel/boinc-v2 $ git stash
warning: CRLF will be replaced by LF in html/languages/translations/hu.po=
.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in html/languages/translations/nl.po=
.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/bg/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/da/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/el/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/fr/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/hr/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/hu/BOINC-Project-Generic.p=
o.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/hu/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/it_IT/BOINC-Project-Generi=
c.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/lv/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/nl/BOINC-Project-Generic.p=
o.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/nl/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/pl/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/pt_BR/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/ro/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/sk/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/zh_TW/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in html/languages/translations/hu.po=
.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in html/languages/translations/nl.po=
.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/bg/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/da/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/el/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/fr/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/hr/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/hu/BOINC-Project-Generic.p=
o.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/hu/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/it_IT/BOINC-Project-Generi=
c.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/lv/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/nl/BOINC-Project-Generic.p=
o.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/nl/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/pl/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/pt_BR/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/ro/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/sk/BOINC-Web.po.
The file will have its original line endings in your working directory.
warning: CRLF will be replaced by LF in locale/zh_TW/BOINC-Web.po.
The file will have its original line endings in your working directory.
Saved working directory and index state WIP on master: ce97e85 MGR: On MS=
 Windows, scale Attach Wizard progress indicators according to user's DPI=
 settings.
HEAD is now at ce97e85 MGR: On MS Windows, scale Attach Wizard progress i=
ndicators according to user's DPI settings.

tfoerste@n22 ~/devel/boinc-v2 $ git pull
Updating ce97e85..d2e5582
error: Your local changes to the following files would be overwritten by =
merge:
        html/languages/translations/hu.po
        html/languages/translations/nl.po
        locale/bg/BOINC-Web.po
        locale/da/BOINC-Web.po
        locale/el/BOINC-Web.po
        locale/fr/BOINC-Web.po
        locale/hr/BOINC-Web.po
        locale/hu/BOINC-Project-Generic.po
        locale/hu/BOINC-Web.po
        locale/it_IT/BOINC-Project-Generic.po
        locale/lv/BOINC-Web.po
        locale/nl/BOINC-Project-Generic.po
        locale/nl/BOINC-Web.po
        locale/pl/BOINC-Web.po
        locale/pt_BR/BOINC-Web.po
        locale/ro/BOINC-Web.po
        locale/sk/BOINC-Web.po
        locale/zh_TW/BOINC-Web.po
Please, commit your changes or stash them before you can merge.
Aborting


Attached are my ~/.gitconfig and ~/devel/boinc-v2/.git/config

--=20
Toralf
pgp key: 0076 E94E


--------------030408060702040307040300
Content-Type: text/plain; charset=UTF-8;
 name=".gitconfig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename=".gitconfig"

W3VzZXJdCgllbWFpbCA9IHRvcmFsZi5mb2Vyc3RlckBnbXguZGUKCW5hbWUgPSBUb3JhbGYg
RsO2cnN0ZXIKCXNpZ25pbmdrZXkgPSAwMDc2ZTk0ZQpbY29yZV0KCXBhZ2VyID0gbGVzcwpb
Z3VpXQoJZm9udHVpID0gLWZhbWlseSBhcmlhbCAtc2l6ZSAxMiAtd2VpZ2h0IGJvbGQgLXNs
YW50IHJvbWFuIC11bmRlcmxpbmUgMCAtb3ZlcnN0cmlrZSAwCglmb250ZGlmZiA9IC1mYW1p
bHkgQ291cmllciAtc2l6ZSAxMiAtd2VpZ2h0IG5vcm1hbCAtc2xhbnQgcm9tYW4gLXVuZGVy
bGluZSAwIC1vdmVyc3RyaWtlIDAKW2NvbG9yXQoJZGlmZiA9IGF1dG8KCXN0YXR1cyA9IGF1
dG8KCWJyYW5jaCA9IGF1dG8KCXVpID0gYXV0bwpbc2VuZGVtYWlsXQoJc210cHNlcnZlciA9
IG1haWwuZ214Lm5ldAoJc210cGVuY3J5cHRpb24gPSB0bHMKCXNtdHB1c2VyID0gdG9yYWxm
LmZvZXJzdGVyQGdteC5kZQoJZnJvbSA9IFRvcmFsZiBGw7Zyc3RlciA8dG9yYWxmLmZvZXJz
dGVyQGdteC5kZT4KCWFzc3VtZThiaXRFbmNvZGluZyA9IFVURi04Cgljb25maXJtID0gbmV2
ZXIKCWNoYWlucmVwbHl0byA9IHRydWUKW2RpZmZdCgkjZXh0ZXJuYWwgPSAvaG9tZS90Zm9l
cnN0ZS93b3Jrc3BhY2UvYmluL2RpZmZ3cmFwLnNoCltwdXNoXQoJZGVmYXVsdCA9IHNpbXBs
ZQpbY3JlZGVudGlhbF0KCWhlbHBlciA9IGNhY2hlIC0tdGltZW91dD0xODAwCg==
--------------030408060702040307040300
Content-Type: text/plain; charset=UTF-8;
 name="config"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="config"

W2NvcmVdCglyZXBvc2l0b3J5Zm9ybWF0dmVyc2lvbiA9IDAKCWZpbGVtb2RlID0gdHJ1ZQoJ
YmFyZSA9IGZhbHNlCglsb2dhbGxyZWZ1cGRhdGVzID0gdHJ1ZQpbcmVtb3RlICJvcmlnaW4i
XQoJdXJsID0gZ2l0Oi8vYm9pbmMuYmVya2VsZXkuZWR1L2JvaW5jLXYyLmdpdAoJZmV0Y2gg
PSArcmVmcy9oZWFkcy8qOnJlZnMvcmVtb3Rlcy9vcmlnaW4vKgpbYnJhbmNoICJtYXN0ZXIi
XQoJcmVtb3RlID0gb3JpZ2luCgltZXJnZSA9IHJlZnMvaGVhZHMvbWFzdGVyCg==
--------------030408060702040307040300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
