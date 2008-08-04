From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Merging submodules
Date: Mon, 4 Aug 2008 15:24:43 +0200
Message-ID: <20080804152443.4418b3e0@pc09.procura.nl>
References: <20080730230336.GA6481@Hermes>
	<20080731143955.034f0577@pc09.procura.nl>
	<20080731130626.GQ32184@machine.or.cz>
	<20080731170123.79e0d3e9@pc09.procura.nl>
	<8aa486160807310824h25c9630dxc25b156e80fcdb29@mail.gmail.com>
	<20080731201530.067be667@pc09.procura.nl>
	<8aa486160807311203o3fb4deb8u4a5ae57818c76fab@mail.gmail.com>
	<20080801090422.55c6a45f@pc09.procura.nl>
	<8aa486160808010252j540a28cdw6e48027396da5248@mail.gmail.com>
	<20080801123523.33c37e08@pc09.procura.nl>
	<8aa486160808010434g7f3c187arc107b994e737cd74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Brian Gernhardt" <benji@silverinsanity.com>,
	"Git List" <git@vger.kernel.org>,
	"Lars Noschinski" <lars-2008-1@usenet.noschinski.de>
To: "Santi =?UTF-8?B?QsOpamFy?=" <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 15:26:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ04h-0002Kr-Mk
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 15:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756494AbYHDNYu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Aug 2008 09:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756155AbYHDNYu
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 09:24:50 -0400
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:3669 "EHLO
	smtp-vbr15.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505AbYHDNYt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2008 09:24:49 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr15.xs4all.nl (8.13.8/8.13.8) with ESMTP id m74DOhYa051159
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Aug 2008 15:24:44 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <8aa486160808010434g7f3c187arc107b994e737cd74@mail.gmail.com>
X-Mailer: Claws Mail 3.5.0cvs35 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91349>

On Fri, 1 Aug 2008 13:34:42 +0200, "Santi B=C3=A9jar" <sbejar@gmail.com=
>
wrote:

> On Fri, Aug 1, 2008 at 12:35, H.Merijn Brand <h.m.brand@xs4all.nl> wr=
ote:
>=20
> >
> > After we join/merge these into the super-project, we're going to re=
move
> > the sup-repos, so all new commits will be made in the super-repo.
>=20
> If you'll remove the subrepos, the best thing would be to rewrite the
> history on those subrepos just moving all the path to the
> corresponding subfolder (with git-filter-branch, and you have exactly
> what you need at the end of the example section in the manpage). And
> then just do a normal merge. Or, even, you could try to create a
> project with everything there in the correct order and location, I
> don't know if git-filter-branch or git-fast-import/export (you have
> some examples in git.git in contrib/fast-import) can do it, but if yo=
u
> get it, please, post it here because it can be useful for others).

I gave up, even thought I'm not satisfied with the result: Merging with
subtrees works, but completely ruins my view over the history, cause
gitk shows the branches as a whole, and not `merged' by date. I did
change the merging process to merge the repo with the least recent
change date first, so that it would show up at the bottom and the
newest on top. This is workable, but far from perfect.

The fast-export/fast import with renaming started out fine, but
fast-import does not merge. For the latter I (tried to) use the
following approach:

--8<---
#!/pro/bin/perl

use strict;
use warnings;

sub usage
{
    my $err =3D shift and select STDERR;
    print "usage: $0 dir|repo.tar\n";
    @_ and print join "\n", @_, "";
    exit $err;
    } # usage

-d "new" and die "Dir new already exists\n";

use Cwd;
use File::Find;
use Getopt::Long qw(:config bundling nopermute);
my $opt_v =3D 1;
GetOptions (
    "help|?"    =3D> sub { usage (0); },

    "v:2"       =3D> \$opt_v,
    ) or usage (1);

@ARGV =3D=3D 1 or usage (1);

my $tmp_archive =3D "/tmp/git-join-$$.tgz";
END { unlink $tmp_archive };

my $archive =3D shift;
if (-d $archive) {
    my $cwd =3D getcwd;
    my @dir;
    chdir $archive or die "$archive: $!\n";
    find (sub {
        $_ eq ".git" && -d $_ and push @dir, $File::Find::name;
        }, ".");
    qx{ tar czf $tmp_archive @dir };
    $archive =3D $tmp_archive;
    chdir $cwd;
    }

sub pr_time
{
    my @d =3D @_;
    sprintf "%4d-%02d-%02d %02d:%02d:%02d", 1900 + $d[5], ++$d[4], @d[3=
,2,1,0];
    } # pr_time

-f $archive && -s _ or usage (1, "Archive is not a file");

my @cmd =3D
    $archive =3D~ m/\.tar$/               ? qw( tar xf  )         :
    $archive =3D~ m/\.t(ar\.)?gz$/        ? qw( tar xzf )         :
    $archive =3D~ m/\.t(ar\.)?bz2?$/      ? qw( tar xhf )         :
    usage (1, "$archive is not a recognized archive type");

print STDERR "Creating merge environment\n";
mkdir "new", 0777;
chdir "new" or die "Canot use folder new\n";

print STDERR "Recovering original repo's\n";
system @cmd, $archive;

my %modules;
find (sub {
    (my $f =3D $File::Find::name) =3D~ s{^\./}{};
    $f =3D~ s{/\.git$}{};
    $_ eq ".git" && -d $_ && !$modules{$f} or return;
    print "Found $f\n";
    system "git-log '--pretty=3Dformat:%ct' | head -1";
    chomp ($modules{$f} =3D `git-log '--pretty=3Dformat:%ct' | head -1`=
);
    }, ".");
my @modules =3D sort { $modules{$a} <=3D> $modules{$b} } keys %modules;

sub git
{
    system "git", @_;
    } # git

my $top =3D getcwd;

print STDERR "Initializing new repo\n";
git "init";

foreach my $mod (@modules) {
    print STDERR "Merging ", pr_time (localtime $modules{$mod}), " $mod=
 ...\n";
    chdir $mod;

    git "checkout", "-f";
    git "filter-branch", "--index-filter",
        qq{git ls-files -s | sed "s-\t-&$mod/-" | }.
         q{GIT_INDEX_FILE=3D$GIT_INDEX_FILE.new }.
         q{git update-index --index-info && }.
         q{mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE}, "HEAD";
    git "fast-export", "--all", ">/tmp/git-export-$$.bin";

    chdir $top;
    git "fast-import", "</tmp/git-export-$$.bin";
    }

print STDERR "Done\n";
-->8---

Which looks perfect after the first import, but fails on every next

Using --force for fast-import removes every previous import, so it is
useless for this process.

I do have to work with the repo, and that is more important than having
a perfect repo.

--=20
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org=
/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00=
,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin=
=2E
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org=
/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers=
/
